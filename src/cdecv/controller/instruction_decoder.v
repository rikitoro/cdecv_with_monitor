`default_nettype none
`include "state.v"

// xsrc {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
`define xsrcPC   3'b000
`define xsrcA    3'b001
`define xsrcB    3'b010
`define xsrcC    3'b011
`define xsrcRD   3'b100
`define xsrcR    3'b101
`define xsrcFLG  3'b110
`define xsrcFF   3'b111

// xdst {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC}
`define xdstNON  10'b00_0000_0000
`define xdstPC   10'b00_0000_0001
`define xdstA    10'b00_0000_0010
`define xdstB    10'b00_0000_0100
`define xdstC    10'b00_0000_1000
`define xdstMA   10'b00_0001_0000
`define xdstWD   10'b00_0010_0000
`define xdstI    10'b00_0100_0000
`define xdstT    10'b00_1000_0000
`define xdstR    10'b01_0000_0000
`define xdstFLG  10'b10_0000_0000

//  aluop | operation
// -------+-------------------
//   0000 | a
//   0001 | b
//   0010 | ~a
//   0011 | ~b
//   0100 | a & b
//   0101 | a | b
//   0110 | a ^ b
//   0111 | 8'b0000_0000
//   1000 | a + 1
//   1001 | a - 1
//   1010 | a + b
//   1011 | a - b
//   1100 | a + b + Cy_in
//   1101 | a - b - Cy_in
//   1110 | a << 1 (shift left)
//   1111 | a >> 1 (shift right)
`define aluopZERO  4'b0111
`define aluopNOT   4'b0010
`define aluopAND   4'b0100
`define aluopOR    4'b0101
`define aluopEOR   4'b0110
`define aluopINC   4'b1000
`define aluopDEC   4'b1001
`define aluopADD   4'b1010
`define aluopSUB   4'b1011
`define aluopADC   4'b1100
`define aluopSBB   4'b1101

module instruction_decoder(
  input wire  [11:0]  state,
  input wire  [7:0]   I,
  input wire  [2:0]   SZCy,
  output wire [2:0]   xsrc,
  output wire [9:0]   xdst,
  output wire [3:0]   aluop,
  output wire         we,
  output wire         end_sq,
  output wire         pause_cc
  );
    
  reg [20:0] control;
  assign {xsrc, xdst, aluop, we, end_sq, pause_cc} = control;
  
  always @ (*) begin
    casex ({state, I, SZCy})
      // reset
      {`state_R,    8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b001};
      // fetch
      {`state_F0,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, (`xdstMA|`xdstR), `aluopINC , 3'b000};
      {`state_F1,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b000};
      {`state_F2,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstI          , `aluopZERO, 3'b000};
      //
      // MOV sreg, dreg
      {`state_MOV0, 8'bxxxx_0101, 3'bxxx}:  control = {`xsrcA , `xdstA          , `aluopZERO, 3'b010};  // MOV A, A
      {`state_MOV0, 8'bxxxx_0110, 3'bxxx}:  control = {`xsrcA , `xdstB          , `aluopZERO, 3'b010};  // MOV A, B
      {`state_MOV0, 8'bxxxx_0111, 3'bxxx}:  control = {`xsrcA , `xdstC          , `aluopZERO, 3'b010};  // MOV A, C
      {`state_MOV0, 8'bxxxx_1001, 3'bxxx}:  control = {`xsrcB , `xdstA          , `aluopZERO, 3'b010};  // MOV B, A
      {`state_MOV0, 8'bxxxx_1010, 3'bxxx}:  control = {`xsrcB , `xdstB          , `aluopZERO, 3'b010};  // MOV B, B
      {`state_MOV0, 8'bxxxx_1011, 3'bxxx}:  control = {`xsrcB , `xdstC          , `aluopZERO, 3'b010};  // MOV B, C
      {`state_MOV0, 8'bxxxx_1101, 3'bxxx}:  control = {`xsrcC , `xdstA          , `aluopZERO, 3'b010};  // MOV C, A
      {`state_MOV0, 8'bxxxx_1110, 3'bxxx}:  control = {`xsrcC , `xdstB          , `aluopZERO, 3'b010};  // MOV C, B
      {`state_MOV0, 8'bxxxx_1111, 3'bxxx}:  control = {`xsrcC , `xdstC          , `aluopZERO, 3'b010};  // MOV C, C
      //
      // LD adrs8, dreg
      {`state_LD0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, (`xdstMA|`xdstR), `aluopINC , 3'b000};
      {`state_LD1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b000};
      {`state_LD2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstMA         , `aluopZERO, 3'b000};
      {`state_LD3,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstNON        , `aluopZERO, 3'b000};
      {`state_LD4,  8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcRD, `xdstA          , `aluopZERO, 3'b010}; // LD adrs8, A
      {`state_LD4,  8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcRD, `xdstB          , `aluopZERO, 3'b010}; // LD adrs8, B
      {`state_LD4,  8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcRD, `xdstC          , `aluopZERO, 3'b010}; // LD adrs8, C
      //
      // ST sreg, adrs8
      {`state_ST0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, (`xdstMA|`xdstR), `aluopINC , 3'b000};
      {`state_ST1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b000};
      {`state_ST2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstMA         , `aluopZERO, 3'b000};
      {`state_ST3,  8'bxxxx_01xx, 3'bxxx}:  control = {`xsrcA , `xdstWD         , `aluopZERO, 3'b000}; // ST A, adrs8
      {`state_ST3,  8'bxxxx_10xx, 3'bxxx}:  control = {`xsrcB , `xdstWD         , `aluopZERO, 3'b000}; // ST B, adrs8
      {`state_ST3,  8'bxxxx_11xx, 3'bxxx}:  control = {`xsrcC , `xdstWD         , `aluopZERO, 3'b000}; // ST C, adrs8
      {`state_ST4,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b110}; 
      //
      // HALT
      {`state_HALT, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b011}; 
      //
      default:                              control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b000};
    endcase   
  end
  
endmodule
