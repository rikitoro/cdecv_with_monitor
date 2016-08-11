`default_nettype none

module address_decoder(
  input wire        we,
  input wire  [7:0] MA,
  //
  output wire       we_ram,
  output wire       we_oport0,
  output wire       we_iport0,
  output wire       sel_ram_io,
  output wire       sel_o_i
  );
  
  reg [2:0] wes;
  reg [1:0] sels;
  
  assign {we_iport0 ,we_oport0, we_ram} = wes;
  assign {sel_o_i, sel_ram_io}        = sels;
  
  always @ (*) begin
    case (we)
      1'b0:
        case (MA)
          8'hff:    {wes, sels} = 5'b000_11;
          8'hfe:    {wes, sels} = 5'b000_01;
          default:  {wes, sels} = 5'b000_00;
        endcase
      1'b1:
        case (MA)
          8'hff:    {wes, sels} = 5'b100_11;
          8'hfe:    {wes, sels} = 5'b010_01;
          default:  {wes, sels} = 5'b001_00;
        endcase      
    endcase
  end

endmodule
