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

// aluop

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
    
  reg [19:0] control;
  assign {xsrc, xdst, aluop, we, end_sq, pause_cc} = control;
  
  always @ (*) begin
    casex ({state, I, SZCy})
      // reset
      {`state_R,    8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b001};
      // fetch
      {`state_F0,   8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC , 3'b000};
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
      {`state_LD0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC , 3'b000};
      {`state_LD1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b000};
      {`state_LD2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstMA         , `aluopZERO, 3'b000};
      {`state_LD3,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstNON        , `aluopZERO, 3'b000};
      {`state_LD4,  8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcRD, `xdstA          , `aluopZERO, 3'b010}; // LD adrs8, A
      {`state_LD4,  8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcRD, `xdstB          , `aluopZERO, 3'b010}; // LD adrs8, B
      {`state_LD4,  8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcRD, `xdstC          , `aluopZERO, 3'b010}; // LD adrs8, C
      //
      // ST sreg, adrs8
      {`state_ST0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC , 3'b000};
      {`state_ST1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b000};
      {`state_ST2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstMA         , `aluopZERO, 3'b000};
      {`state_ST3,  8'bxxxx_01xx, 3'bxxx}:  control = {`xsrcA , `xdstWD         , `aluopZERO, 3'b000}; // ST A, adrs8
      {`state_ST3,  8'bxxxx_10xx, 3'bxxx}:  control = {`xsrcB , `xdstWD         , `aluopZERO, 3'b000}; // ST B, adrs8
      {`state_ST3,  8'bxxxx_11xx, 3'bxxx}:  control = {`xsrcC , `xdstWD         , `aluopZERO, 3'b000}; // ST C, adrs8
      {`state_ST4,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b110};
      //  
      // ADD reg
      {`state_ADD0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // ADD A
      {`state_ADD0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // ADD B
      {`state_ADD0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // ADD C
      {`state_ADD1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopADD , 3'b000};
      {`state_ADD2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //  
      // ADC reg
      {`state_ADC0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // ADC A
      {`state_ADC0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // ADC B
      {`state_ADC0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // ADC C
      {`state_ADC1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopADC , 3'b000};
      {`state_ADC2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // SUB reg
      {`state_SUB0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // SUB A
      {`state_SUB0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // SUB B
      {`state_SUB0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // SUB C
      {`state_SUB1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopSUB , 3'b000};
      {`state_SUB2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // SBB reg
      {`state_SBB0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // SBB A
      {`state_SBB0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // SBB B
      {`state_SBB0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // SBB C
      {`state_SBB1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopSBB , 3'b000};
      {`state_SBB2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // AND reg
      {`state_AND0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // AND A
      {`state_AND0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // AND B
      {`state_AND0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // AND C
      {`state_AND1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopAND , 3'b000};
      {`state_AND2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // OR reg
      {`state_OR0,  8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // OR A
      {`state_OR0,  8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // OR B
      {`state_OR0,  8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // OR C
      {`state_OR1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopOR  , 3'b000};
      {`state_OR2,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // EOR reg
      {`state_EOR0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstT          , `aluopZERO, 3'b000}; // EOR A
      {`state_EOR0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstT          , `aluopZERO, 3'b000}; // EOR B
      {`state_EOR0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstT          , `aluopZERO, 3'b000}; // EOR C
      {`state_EOR1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopEOR , 3'b000};
      {`state_EOR2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010};
      //
      // INC reg
      {`state_INC0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopINC , 3'b000}; // INC A
      {`state_INC0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstR|`xdstFLG , `aluopINC , 3'b000}; // INC B
      {`state_INC0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstR|`xdstFLG , `aluopINC , 3'b000}; // INC C
      {`state_INC1, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010}; // INC A
      {`state_INC1, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcR , `xdstB          , `aluopZERO, 3'b010}; // INC A
      {`state_INC1, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcR , `xdstC          , `aluopZERO, 3'b010}; // INC A
      //
      // DEC reg
      {`state_DEC0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopDEC , 3'b000}; // DEC A
      {`state_DEC0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstR|`xdstFLG , `aluopDEC , 3'b000}; // DEC B
      {`state_DEC0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstR|`xdstFLG , `aluopDEC , 3'b000}; // DEC C
      {`state_DEC1, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010}; // DEC A
      {`state_DEC1, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcR , `xdstB          , `aluopZERO, 3'b010}; // DEC A
      {`state_DEC1, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcR , `xdstC          , `aluopZERO, 3'b010}; // DEC A
      //
      // NOT reg
      {`state_NOT0, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcA , `xdstR|`xdstFLG , `aluopNOT , 3'b000}; // NOT A
      {`state_NOT0, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcB , `xdstR|`xdstFLG , `aluopNOT , 3'b000}; // NOT B
      {`state_NOT0, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcC , `xdstR|`xdstFLG , `aluopNOT , 3'b000}; // NOT C
      {`state_NOT1, 8'bxxxx_xx01, 3'bxxx}:  control = {`xsrcR , `xdstA          , `aluopZERO, 3'b010}; // NOT A
      {`state_NOT1, 8'bxxxx_xx10, 3'bxxx}:  control = {`xsrcR , `xdstB          , `aluopZERO, 3'b010}; // NOT B
      {`state_NOT1, 8'bxxxx_xx11, 3'bxxx}:  control = {`xsrcR , `xdstC          , `aluopZERO, 3'b010}; // NOT C
      //
      // JMP adrs8
      {`state_JMP0, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA         , `aluopZERO, 3'b000};
      {`state_JMP1, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b000};
      {`state_JMP2, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcRD, `xdstPC         , `aluopZERO, 3'b010};
      //
      // JS adrs8
      {`state_JS0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC,  3'b000};
      {`state_JS1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b000};
      {`state_JS2,  8'bxxxx_xxxx, 3'b0xx}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b010}; // S = 0
      {`state_JS2,  8'bxxxx_xxxx, 3'b1xx}:  control = {`xsrcRD, `xdstPC         , `aluopZERO, 3'b010}; // S = 1
      //
      // JZ adrs8
      {`state_JZ0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC,  3'b000};
      {`state_JZ1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b000};
      {`state_JZ2,  8'bxxxx_xxxx, 3'bx0x}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b010}; // Z = 0
      {`state_JZ2,  8'bxxxx_xxxx, 3'bx1x}:  control = {`xsrcRD, `xdstPC         , `aluopZERO, 3'b010}; // Z = 1
      //
      // JZ adrs8
      {`state_JC0,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcPC, `xdstMA|`xdstR  , `aluopINC,  3'b000};
      {`state_JC1,  8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b000};
      {`state_JC2,  8'bxxxx_xxxx, 3'bxx0}:  control = {`xsrcR , `xdstPC         , `aluopZERO, 3'b010}; // Cy = 0
      {`state_JC2,  8'bxxxx_xxxx, 3'bxx1}:  control = {`xsrcRD, `xdstPC         , `aluopZERO, 3'b010}; // Cy = 1

      // HALT
      {`state_HALT, 8'bxxxx_xxxx, 3'bxxx}:  control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b011}; 
      //
      default:                              control = {`xsrcFF, `xdstNON        , `aluopZERO, 3'b010};
    endcase   
  end
  
endmodule
