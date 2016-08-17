
`define code_MOV  8'b0000_00xx
`define code_LD   8'b1000_00xx
`define code_ST   8'b1010_xx00
`define code_ADD  8'b0010_00xx
`define code_ADC  8'b0010_01xx
`define code_SUB  8'b0010_10xx
`define code_SBB  8'b0010_11xx
`define code_AND  8'b0011_00xx
`define code_OR   8'b0011_01xx
`define code_EOR  8'b0011_11xx
`define code_INC  8'b0100_00xx
`define code_DEC  8'b0100_01xx
`define code_NOT  8'b0101_00xx
`define code_JMP  8'b1100_0000
`define code_JS   8'b1111_0000
`define code_JZ   8'b1110_1000
`define code_JC   8'b1110_0100
`define code_HALT 8'b1111_1111
