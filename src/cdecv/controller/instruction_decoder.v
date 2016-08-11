`default_nettype none
`include "state.v"

// xsrc {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
`define xsrc_PC   3'b000
`define xsrc_A    3'b001
`define xsrc_B    3'b010
`define xsrc_C    3'b011
`define xsrc_RD   3'b100
`define xsrc_R    3'b101
`define xsrc_FLG  3'b110
`define xsrc_FF   3'b111

// xdst {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC}
`define xdst_NON  10'b00_0000_0000
`define xdst_PC   10'b00_0000_0001
`define xdst_A    10'b00_0000_0010
`define xdst_B    10'b00_0000_0100
`define xdst_C    10'b00_0000_1000
`define xdst_MA   10'b00_0001_0000
`define xdst_WD   10'b00_0010_0000
`define xdst_I    10'b00_0100_0000
`define xdst_T    10'b00_1000_0000
`define xdst_R    10'b01_0000_0000
`define xdst_FLG  10'b10_0000_0000

// aluop
`define aluop_ZERO  5'b00000
`define aluop_ADD   5'b01000
`define aluop_ADC   5'b01010
`define aluop_SUB   5'b01011
`define aluop_SBB   5'b01101
`define aluop_AND   5'b10000
`define aluop_OR    5'b10001
`define aluop_EOR   5'b10010
`define aluop_INC   5'b01110
`define aluop_DEC   5'b01111
`define aluop_NOT   5'b10011


module instruction_decoder(
  input wire  [11:0]  state,
  input wire  [7:0]   I,
  input wire  [2:0]   SZCy,
  output wire [2:0]   xsrc,
  output wire [9:0]   xdst,
  output wire [4:0]   aluop,
  output wire         we,
  output wire         end_sq,
  output wire         halt
  );
    
  reg [20:0] control;
  assign {xsrc, xdst, aluop, we, end_sq, halt} = control;
  
  always @ (*) begin
    casex ({state, I, SZCy})
      // reset
      {`state_R,    8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_FF,  `xdst_NON,            `aluop_ZERO,  3'b000};
      // fetch
      {`state_F0,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_PC,  (`xdst_MA | `xdst_R), `aluop_INC,   3'b000};
      {`state_F1,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_R,   `xdst_PC,             `aluop_ZERO,  3'b000};
      {`state_F2,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_RD,  `xdst_I,              `aluop_ZERO,  3'b000};
      //
      // MOV sreg, dreg
      {`state_MOV0, 8'bxxxx_0101, 3'bxxx}:  control = {`xsrc_A,   `xdst_A,              `aluop_ZERO,  3'b010};  // MOV A, A
      {`state_MOV0, 8'bxxxx_0110, 3'bxxx}:  control = {`xsrc_A,   `xdst_B,              `aluop_ZERO,  3'b010};  // MOV A, B
      {`state_MOV0, 8'bxxxx_0111, 3'bxxx}:  control = {`xsrc_A,   `xdst_C,              `aluop_ZERO,  3'b010};  // MOV A, C
      {`state_MOV0, 8'bxxxx_1001, 3'bxxx}:  control = {`xsrc_B,   `xdst_A,              `aluop_ZERO,  3'b010};  // MOV B, A
      {`state_MOV0, 8'bxxxx_1010, 3'bxxx}:  control = {`xsrc_B,   `xdst_B,              `aluop_ZERO,  3'b010};  // MOV B, B
      {`state_MOV0, 8'bxxxx_1011, 3'bxxx}:  control = {`xsrc_B,   `xdst_C,              `aluop_ZERO,  3'b010};  // MOV B, C
      {`state_MOV0, 8'bxxxx_1101, 3'bxxx}:  control = {`xsrc_C,   `xdst_A,              `aluop_ZERO,  3'b010};  // MOV C, A
      {`state_MOV0, 8'bxxxx_1110, 3'bxxx}:  control = {`xsrc_C,   `xdst_B,              `aluop_ZERO,  3'b010};  // MOV C, B
      {`state_MOV0, 8'bxxxx_1111, 3'bxxx}:  control = {`xsrc_C,   `xdst_C,              `aluop_ZERO,  3'b010};  // MOV C, C
      //
      // LD adrs8, dreg
      {`state_LD0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_PC,  (`xdst_MA | `xdst_R), `aluop_INC,   3'b000};
      {`state_LD1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_R,   `xdst_PC,             `aluop_ZERO,  3'b000};
      {`state_LD2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_RD,  `xdst_MA,             `aluop_ZERO,  3'b000};
      {`state_LD3,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_RD,  `xdst_NON,            `aluop_ZERO,  3'b000};
      {`state_LD4,  8'bxxxx_xx01, 3'bxxx}:  control = {`xsrc_RD,  `xdst_A,              `aluop_ZERO,  3'b010}; // LD adrs8, A
      {`state_LD4,  8'bxxxx_xx10, 3'bxxx}:  control = {`xsrc_RD,  `xdst_B,              `aluop_ZERO,  3'b010}; // LD adrs8, B
      {`state_LD4,  8'bxxxx_xx11, 3'bxxx}:  control = {`xsrc_RD,  `xdst_C,              `aluop_ZERO,  3'b010}; // LD adrs8, C
      //
      // ST sreg, adrs8
      {`state_ST0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_PC,  (`xdst_MA | `xdst_R), `aluop_INC,   3'b000};
      {`state_ST1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_R,   `xdst_PC,             `aluop_ZERO,  3'b000};
      {`state_ST2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_RD,  `xdst_MA,             `aluop_ZERO,  3'b000};
      {`state_ST3,  8'bxxxx_01xx, 3'bxxx}:  control = {`xsrc_A,   `xdst_WD,             `aluop_ZERO,  3'b100}; // ST A, adrs8
      {`state_ST3,  8'bxxxx_01xx, 3'bxxx}:  control = {`xsrc_B,   `xdst_WD,             `aluop_ZERO,  3'b100}; // ST B, adrs8
      {`state_ST3,  8'bxxxx_01xx, 3'bxxx}:  control = {`xsrc_C,   `xdst_WD,             `aluop_ZERO,  3'b100}; // ST C, adrs8
      {`state_ST4,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_FF,  `xdst_NON,            `aluop_ZERO,  3'b010}; 
      //
      // HALT
      {`state_HALT, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrc_FF,  `xdst_NON,            `aluop_ZERO,  3'b011}; 
      //
      default:                              control = {`xsrc_FF,  `xdst_NON,            `aluop_ZERO,  3'b000};
    endcase
  end
  
endmodule
