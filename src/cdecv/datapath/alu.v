`default_nettype none

module alu(
  input wire  [4:0] aluop,
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
      5'b00000: result1 = 8'h00;
      5'b00001: result1 = a;
      5'b00010: result1 = b;
      //
      5'b01000: result1 = a + b;
      5'b01001: result1 = a + b + 1'b1;
      5'b01010: result1 = a + b + Cy_in;
      5'b01011: result1 = a - b;
      5'b01100: result1 = a - b - 1'b1;
      5'b01101: result1 = a - b - Cy_in;
      5'b01110: result1 = a + 1'b1;
      5'b01111: result1 = a - 1'b1;
      //
      5'b10000: result1 = a & b;
      5'b10001: result1 = a | b;
      5'b10010: result1 = a ^ b;
      5'b10011: result1 = ~a;
      5'b10100: result1 = ~b;
      //
      5'b11000: result1 = {1'b0, 1'b0, a[7:1]}; // shift right
      5'b11011: result1 = {a[7:0], 1'b0};       // shift left
      //
      default:  result1 = 8'h00;
    endcase
  end
endmodule
