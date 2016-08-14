`default_nettype none

module address_decoder(
  input wire        we,
  input wire  [7:0] MA,
  //
  output reg        we_ram,
  output reg        we_io,
  output reg        sel_ram_io
  );
  
    
  always @ (*) begin
    case (we)
      1'b0:
        case (MA)
          8'hff:    {we_ram, we_io, sel_ram_io} = 3'b00_1;
          default:  {we_ram, we_io, sel_ram_io} = 3'b00_0;
        endcase
      1'b1:
        case (MA)
          8'hff:    {we_ram, we_io, sel_ram_io} = 3'b01_1;
          default:  {we_ram, we_io, sel_ram_io} = 3'b10_0;
        endcase      
    endcase
  end

endmodule
