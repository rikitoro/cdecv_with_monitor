`default_nettype none

//  Function of alu
//
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

module alu(
  input wire  [3:0] aluop,
  input wire  [7:0] a,
  input wire  [7:0] b,
  input wire        Cy_in,
  output wire [7:0] result,
  output wire [2:0] SZCy
  );
  
  reg [8:0] result1;
  wire S, Z, Cy;
  
  assign result = result1[7:0];
  assign S      = result1[7];
  assign Z      = (result1[7:0] == 8'h00) ? 1'b1 : 1'b0;
  assign Cy     = result1[8];
  assign SZCy   = {S, Z, Cy};

  always @ (*) begin
    casex (aluop) 
      4'b0000: result1 = a;
      4'b0001: result1 = b;
      4'b0010: result1 = ~a;
      4'b0011: result1 = ~b;
      4'b0100: result1 = a & b;
      4'b0101: result1 = a | b;
      4'b0110: result1 = a ^ b;
      4'b0111: result1 = 8'b0000_0000;
      4'b1000: result1 = a + 1'b1;
      4'b1001: result1 = a - 1'b1;
      4'b1010: result1 = a + b;
      4'b1011: result1 = a - b;
      4'b1100: result1 = a + b + Cy_in;
      4'b1101: result1 = a - b - Cy_in;
      4'b1110: result1 = {a, 1'b0};
      4'b1111: result1 = {2'b00, a[7:1]};  
    endcase
  end
endmodule
