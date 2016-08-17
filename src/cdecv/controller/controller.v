`default_nettype none
`include "state.v"
`include "code.v"

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
        {`state_R   , 8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F0;
        // fetch cycle
        {`state_F0  , 8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F1;
        {`state_F1  , 8'bxxxx_xxxx, 3'bxxx}:  state <= `state_F2;
        // MOV sreg, dreg
        {`state_F2  , `code_MOV , 3'bxxx}:  state <= `state_MOV0;
        {`state_MOV0, `code_MOV , 3'bxxx}:  state <= `state_F0;
        // LD adrs8, dreg
        {`state_F2  , `code_LD  , 3'bxxx}:  state <= `state_LD0;
        {`state_LD0 , `code_LD  , 3'bxxx}:  state <= `state_LD1;
        {`state_LD1 , `code_LD  , 3'bxxx}:  state <= `state_LD2;
        {`state_LD2 , `code_LD  , 3'bxxx}:  state <= `state_LD3;
        {`state_LD3 , `code_LD  , 3'bxxx}:  state <= `state_LD4;
        {`state_LD4 , `code_LD  , 3'bxxx}:  state <= `state_F0;
        // ST sreg, adrs8
        {`state_F2  , `code_ST  , 3'bxxx}:  state <= `state_ST0;
        {`state_ST0 , `code_ST  , 3'bxxx}:  state <= `state_ST1;
        {`state_ST1 , `code_ST  , 3'bxxx}:  state <= `state_ST2;
        {`state_ST2 , `code_ST  , 3'bxxx}:  state <= `state_ST3;
        {`state_ST3 , `code_ST  , 3'bxxx}:  state <= `state_ST4;
        {`state_ST4 , `code_ST  , 3'bxxx}:  state <= `state_F0;
        // ADD reg
        {`state_F2  , `code_ADD , 3'bxxx}:  state <= `state_ADD0; // T <- reg
        {`state_ADD0, `code_ADD , 3'bxxx}:  state <= `state_ADD1; // R <- A + T
        {`state_ADD1, `code_ADD , 3'bxxx}:  state <= `state_ADD2; // A <- R
        {`state_ADD2, `code_ADD , 3'bxxx}:  state <= `state_F0;
        // ADC reg
        {`state_F2,   `code_ADC , 3'bxxx}:  state <= `state_ADC0; // T <- reg
        {`state_ADC0, `code_ADC , 3'bxxx}:  state <= `state_ADC1; // R <- A + T + Cy
        {`state_ADC1, `code_ADC , 3'bxxx}:  state <= `state_ADC2; // A <- R
        {`state_ADC2, `code_ADC , 3'bxxx}:  state <= `state_F0;
        // SUB reg
        {`state_F2  , `code_SUB , 3'bxxx}:  state <= `state_SUB0; // T <- reg
        {`state_SUB0, `code_SUB , 3'bxxx}:  state <= `state_SUB1; // R <- A - T
        {`state_SUB1, `code_SUB , 3'bxxx}:  state <= `state_SUB2; // A <- R
        {`state_SUB2, `code_SUB , 3'bxxx}:  state <= `state_F0;
        // SBB reg
        {`state_F2  , `code_SBB , 3'bxxx}:  state <= `state_SBB0; // T <- reg
        {`state_SBB0, `code_SBB , 3'bxxx}:  state <= `state_SBB1; // R <- A - T - Cy
        {`state_SBB1, `code_SBB , 3'bxxx}:  state <= `state_SBB2; // A <- R
        {`state_SBB2, `code_SBB , 3'bxxx}:  state <= `state_F0;
        // AND reg
        {`state_F2  , `code_AND , 3'bxxx}:  state <= `state_AND0; // T <- reg
        {`state_AND0, `code_AND , 3'bxxx}:  state <= `state_AND1; // R <- A & T
        {`state_AND1, `code_AND , 3'bxxx}:  state <= `state_AND2; // A <- R
        {`state_AND2, `code_AND , 3'bxxx}:  state <= `state_F0;
        // OR reg
        {`state_F2  , `code_OR  , 3'bxxx}:  state <= `state_OR0; // T <- reg
        {`state_OR0 , `code_OR  , 3'bxxx}:  state <= `state_OR1; // R <- A | T
        {`state_OR1 , `code_OR  , 3'bxxx}:  state <= `state_OR2; // A <- R
        {`state_OR2 , `code_OR  , 3'bxxx}:  state <= `state_F0;
        // EOR reg
        {`state_F2  , `code_EOR , 3'bxxx}:  state <= `state_EOR0; // T <- reg
        {`state_EOR0, `code_EOR , 3'bxxx}:  state <= `state_EOR1; // R <- A ^ T
        {`state_EOR1, `code_EOR , 3'bxxx}:  state <= `state_EOR2; // A <- R
        {`state_EOR2, `code_EOR , 3'bxxx}:  state <= `state_F0;
        // INC reg
        {`state_F2  , `code_INC , 3'bxxx}:  state <= `state_INC0; // R <- reg + 1
        {`state_INC0, `code_INC , 3'bxxx}:  state <= `state_INC1; // reg <- R 
        {`state_INC1, `code_INC , 3'bxxx}:  state <= `state_F0;
        // DEC reg
        {`state_F2  , `code_DEC , 3'bxxx}:  state <= `state_DEC0; // R <- reg - 1
        {`state_DEC0, `code_DEC , 3'bxxx}:  state <= `state_DEC1; // reg <- R 
        {`state_DEC1, `code_DEC , 3'bxxx}:  state <= `state_F0;
        // NOT reg
        {`state_F2  , `code_NOT , 3'bxxx}:  state <= `state_NOT0; // R <- ~reg
        {`state_NOT0, `code_NOT , 3'bxxx}:  state <= `state_NOT1; // reg <- R 
        {`state_NOT1, `code_NOT , 3'bxxx}:  state <= `state_F0;
        // JMP adrs8
        {`state_F2  , `code_JMP , 3'bxxx}:  state <= `state_JMP0; // MA <- PC
        {`state_JMP0, `code_JMP , 3'bxxx}:  state <= `state_JMP1; // (RD <- RAM)
        {`state_JMP1, `code_JMP , 3'bxxx}:  state <= `state_JMP2; // PC <- RD
        {`state_JMP2, `code_JMP , 3'bxxx}:  state <= `state_F0;
        // JS adrs8
        {`state_F2  , `code_JS  , 3'bxxx}:  state <= `state_JS0;  // MA <- PC, R <- PC + 1
        {`state_JS0 , `code_JS  , 3'bxxx}:  state <= `state_JS1;  // (RD <- RAM)
        {`state_JS1 , `code_JS  , 3'bxxx}:  state <= `state_JS2;  // PC <- (S == 1) ? RD : R
        {`state_JS2 , `code_JS  , 3'bxxx}:  state <= `state_F0;
        // JZ adrs8
        {`state_F2  , `code_JZ  , 3'bxxx}:  state <= `state_JZ0;  // MA <- PC, R <- PC + 1
        {`state_JZ0 , `code_JZ  , 3'bxxx}:  state <= `state_JZ1;  // (RD <- RAM)
        {`state_JZ1 , `code_JZ  , 3'bxxx}:  state <= `state_JZ2;  // PC <- (Z == 1) ? RD : R
        {`state_JZ2 , `code_JZ  , 3'bxxx}:  state <= `state_F0;
        // JC adrs8
        {`state_F2  , `code_JC  , 3'bxxx}:  state <= `state_JC0;  // MA <- PC, R <- PC + 1
        {`state_JC0 , `code_JC  , 3'bxxx}:  state <= `state_JC1;  // (RD <- RAM)
        {`state_JC1 , `code_JC  , 3'bxxx}:  state <= `state_JC2;  // PC <- (Cy == 1) ? RD : R
        {`state_JC2 , `code_JC  , 3'bxxx}:  state <= `state_F0;

        // HALT
        {`state_F2  , `code_HALT, 3'bxxx}:  state <= `state_HALT;
        {`state_HALT, `code_HALT, 3'bxxx}:  state <= `state_HALT;
        //
        default:                            state <= `state_HALT;
      endcase
    end
  end
  
endmodule
