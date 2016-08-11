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
  output wire [4:0] aluop,    // select alu operation
  // memory write enable
  output wire       we,
  // end sequence
  output wire       end_sq,
  // halt signal
  output wire       halt
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
    .halt     (halt));
  
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
        // HALT
        {`state_F2,   8'b1111_1111, 3'bxxx}:  state <= `state_HALT;
        {`state_HALT, 8'b1111_1111, 3'bxxx}:  state <= `state_HALT;
        //
        default:                              state <= `state_R;
      endcase
    end
  end
  
endmodule
