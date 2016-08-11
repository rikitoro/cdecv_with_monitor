`default_nettype none

module hex_display(
  input wire  [3:0] d,
  output wire [6:0] hex);

  reg[6:0] decoder;

  assign hex = ~decoder; // 7seg are active low

  always @ (*) begin
    case (d)
      4'h0    : decoder = 7'b011_1111;
      4'h1    : decoder = 7'b000_0110;
      4'h2    : decoder = 7'b101_1011;
      4'h3    : decoder = 7'b100_1111;
      4'h4    : decoder = 7'b110_0110;
      4'h5    : decoder = 7'b110_1101;
      4'h6    : decoder = 7'b111_1101;
      4'h7    : decoder = 7'b010_0111;
      4'h8    : decoder = 7'b111_1111;
      4'h9    : decoder = 7'b110_1111;
      4'ha    : decoder = 7'b111_0111;
      4'hb    : decoder = 7'b111_1100;
      4'hc    : decoder = 7'b101_1000;
      4'hd    : decoder = 7'b101_1110;
      4'he    : decoder = 7'b111_1001;
      4'hf    : decoder = 7'b111_0001;
      default : decoder = 7'b000_0000;
    endcase
  end
  
endmodule
