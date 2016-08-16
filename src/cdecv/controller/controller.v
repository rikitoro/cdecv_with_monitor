`default_nettype none
`include "state.v"

module controller (
  input wire          clock,
  input wire          reset,
  // controller <=> datapath
  input wire  [7:0] I,
  input wire  [2:0] SZCy,
  output wire [2:0] xsrc,     // read {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
  output wire [9:0] xdst,     // write enable {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC} 
  output wire [3:0] aluop,    // select alu operation
  // memory write enable
  output wire       we,
  // end sequence
  output wire       end_sq,
  // pause cycle counter
  output wire       pause_cc
  );
  
  reg [11:0] state;

  instruction_decoder instruction_decoder(
    .state    (state),
    .I        (I),
    .SZCy     (SZCy),
    .xsrc     (xsrc),
    .xdst     (xdst),
    .aluop    (aluop),
    .we       (we),
    .end_sq   (end_sq),
    .pause_cc (pause_cc));
  
  always @ (negedge clock, posedge reset) begin
    if (reset) begin
      state <= `state_R;
    end else begin
      casex ({state, I, SZCy})
        // reset
        {`state_R,    8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F0;
        // fetch cycle
        {`state_F0,   8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F1;
        {`state_F1,   8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F2;
        // MOV sreg, dreg
        {`state_F2,   8'b0000_xxxx, 3'bxxx}:  state <= `state_MOV0;
        {`state_MOV0, 8'b0000_xxxx, 3'bxxx}:  state <= `state_F0;
        // LD adrs8, dreg
        {`state_F2,   8'b1000_00xx, 3'bxxx}:  state <= `state_LD0;
        {`state_LD0,  8'b1000_00xx, 3'bxxx}:  state <= `state_LD1;
        {`state_LD1,  8'b1000_00xx, 3'bxxx}:  state <= `state_LD2;
        {`state_LD2,  8'b1000_00xx, 3'bxxx}:  state <= `state_LD3;
        {`state_LD3,  8'b1000_00xx, 3'bxxx}:  state <= `state_LD4;
        {`state_LD4,  8'b1000_00xx, 3'bxxx}:  state <= `state_F0;
        // ST sreg, adrs8
        {`state_F2,   8'b1010_xx00, 3'bxxx}:  state <= `state_ST0;
        {`state_ST0,  8'b1010_xx00, 3'bxxx}:  state <= `state_ST1;
        {`state_ST1,  8'b1010_xx00, 3'bxxx}:  state <= `state_ST2;
        {`state_ST2,  8'b1010_xx00, 3'bxxx}:  state <= `state_ST3;
        {`state_ST3,  8'b1010_xx00, 3'bxxx}:  state <= `state_ST4;
        {`state_ST4,  8'b1010_xx00, 3'bxxx}:  state <= `state_F0;
        // ADD reg
        {`state_F2,   8'b0010_00xx, 3'bxxx}:  state <= `state_ADD0; // T <- reg
        {`state_ADD0, 8'b0010_00xx, 3'bxxx}:  state <= `state_ADD1; // R <- A + T
        {`state_ADD1, 8'b0010_00xx, 3'bxxx}:  state <= `state_ADD2; // A <- R
        {`state_ADD2, 8'b0010_00xx, 3'bxxx}:  state <= `state_F0;
        // ADC reg
        {`state_F2,   8'b0010_01xx, 3'bxxx}:  state <= `state_ADC0; // T <- reg
        {`state_ADC0, 8'b0010_01xx, 3'bxxx}:  state <= `state_ADC1; // R <- A + T + Cy
        {`state_ADC1, 8'b0010_01xx, 3'bxxx}:  state <= `state_ADC2; // A <- R
        {`state_ADC2, 8'b0010_01xx, 3'bxxx}:  state <= `state_F0;
        // SUB reg
        {`state_F2,   8'b0010_10xx, 3'bxxx}:  state <= `state_SUB0; // T <- reg
        {`state_SUB0, 8'b0010_10xx, 3'bxxx}:  state <= `state_SUB1; // R <- A - T
        {`state_SUB1, 8'b0010_10xx, 3'bxxx}:  state <= `state_SUB2; // A <- R
        {`state_SUB2, 8'b0010_10xx, 3'bxxx}:  state <= `state_F0;
        // SBB reg
        {`state_F2,   8'b0010_11xx, 3'bxxx}:  state <= `state_SBB0; // T <- reg
        {`state_SBB0, 8'b0010_11xx, 3'bxxx}:  state <= `state_SBB1; // R <- A - T - Cy
        {`state_SBB1, 8'b0010_11xx, 3'bxxx}:  state <= `state_SBB2; // A <- R
        {`state_SBB2, 8'b0010_11xx, 3'bxxx}:  state <= `state_F0;
        // AND reg
        {`state_F2,   8'b0011_00xx, 3'bxxx}:  state <= `state_AND0; // T <- reg
        {`state_AND0, 8'b0011_00xx, 3'bxxx}:  state <= `state_AND1; // R <- A & T
        {`state_AND1, 8'b0011_00xx, 3'bxxx}:  state <= `state_AND2; // A <- R
        {`state_AND2, 8'b0011_00xx, 3'bxxx}:  state <= `state_F0;
        // OR reg
        {`state_F2,   8'b0011_01xx, 3'bxxx}:  state <= `state_OR0; // T <- reg
        {`state_OR0,  8'b0011_01xx, 3'bxxx}:  state <= `state_OR1; // R <- A | T
        {`state_OR1,  8'b0011_01xx, 3'bxxx}:  state <= `state_OR2; // A <- R
        {`state_OR2,  8'b0011_01xx, 3'bxxx}:  state <= `state_F0;
        // EOR reg
        {`state_F2,   8'b0011_11xx, 3'bxxx}:  state <= `state_EOR0; // T <- reg
        {`state_EOR0, 8'b0011_11xx, 3'bxxx}:  state <= `state_EOR1; // R <- A ^ T
        {`state_EOR1, 8'b0011_11xx, 3'bxxx}:  state <= `state_EOR2; // A <- R
        {`state_EOR2, 8'b0011_11xx, 3'bxxx}:  state <= `state_F0;
        // INC reg
        {`state_F2,   8'b0100_00xx, 3'bxxx}:  state <= `state_INC0; // R <- reg + 1
        {`state_INC0, 8'b0100_00xx, 3'bxxx}:  state <= `state_INC1; // reg <- R 
        {`state_INC1, 8'b0100_00xx, 3'bxxx}:  state <= `state_F0;
        // DEC reg
        {`state_F2,   8'b0100_01xx, 3'bxxx}:  state <= `state_DEC0; // R <- reg - 1
        {`state_DEC0, 8'b0100_01xx, 3'bxxx}:  state <= `state_DEC1; // reg <- R 
        {`state_DEC1, 8'b0100_01xx, 3'bxxx}:  state <= `state_F0;
        // NOT reg
        {`state_F2,   8'b0101_00xx, 3'bxxx}:  state <= `state_NOT0; // R <- ~reg
        {`state_NOT0, 8'b0101_00xx, 3'bxxx}:  state <= `state_NOT1; // reg <- R 
        {`state_NOT1, 8'b0101_00xx, 3'bxxx}:  state <= `state_F0;
        
        // HALT
        {`state_F2,   8'b1111_1111, 3'bxxx}:  state <= `state_HALT;
        {`state_HALT, 8'b1111_1111, 3'bxxx}:  state <= `state_HALT;
        //
        default:                              state <= `state_HALT;
      endcase
    end
  end
  
endmodule
