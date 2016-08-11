`default_nettype none

//

module mux2(
  input wire        sel,
  input wire  [7:0] d0,
  input wire  [7:0] d1,
  output wire [7:0] y
  );
  
  assign y = (sel == 1'b0) ? d0 : d1;
endmodule

//

module mux8(
  input wire  [2:0] sel,
  input wire  [7:0] d0,
  input wire  [7:0] d1,
  input wire  [7:0] d2,
  input wire  [7:0] d3,
  input wire  [7:0] d4,
  input wire  [7:0] d5,
  input wire  [7:0] d6,
  input wire  [7:0] d7,
  output reg  [7:0] y  
  );
  
  always @ (*) begin
    case (sel)
      3'b000: y = d0;
      3'b001: y = d1;
      3'b010: y = d2;
      3'b011: y = d3;
      3'b100: y = d4;
      3'b101: y = d5;
      3'b110: y = d6;
      3'b111: y = d7;
    endcase
  end
endmodule

