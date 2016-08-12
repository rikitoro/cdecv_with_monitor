`default_nettype none

module hex_display(
  input wire  [3:0] d,
  output reg  [6:0] hex);

  always @ (*) begin
    case (d)
      4'h0    : hex = 7'b100_0000;
      4'h1    : hex = 7'b111_1001;
      4'h2    : hex = 7'b010_0100;
      4'h3    : hex = 7'b011_0000;
      4'h4    : hex = 7'b001_1001;
      4'h5    : hex = 7'b001_0010;
      4'h6    : hex = 7'b000_0010;
      4'h7    : hex = 7'b101_1000;
      4'h8    : hex = 7'b000_0000;
      4'h9    : hex = 7'b001_0000;
      4'ha    : hex = 7'b000_1000;
      4'hb    : hex = 7'b000_0011;
      4'hc    : hex = 7'b010_0111;
      4'hd    : hex = 7'b010_0001;
      4'he    : hex = 7'b000_0110;
      4'hf    : hex = 7'b000_1110;
    endcase
  end
  
endmodule
