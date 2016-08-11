`default_nettype none

module memory(
  input wire        clock,
  input wire        we,
  input wire  [7:0] MA,
  input wire  [7:0] WD,
  output wire [7:0] RD,
  //
  input wire        prg_clock,
  input wire        prg_we,
  input wire  [7:0] prg_MA,
  input wire  [7:0] prg_WD,
  output wire [7:0] prg_RD,
  //
  output wire [7:0] oport0,
  input wire  [7:0] iport0
  );
  
  
  //// ram $0x00~0xFD
  
  wire        we_ram;
  wire [7:0]  RD_ram;
  dualport_ram  dualport_ram(
    .clock_a    (clock),
    .wren_a     (we_ram),
    .address_a  (MA),
    .data_a     (WD),
    .q_a        (RD_ram),
    //
    .clock_b    (prg_clock),
    .wren_b     (prg_we),
    .address_b  (prg_MA),
    .data_b     (prg_WD),
    .q_b        (prg_RD));

  //// output port0 $0xFE
  wire        we_oport0;
  wire [7:0]  RD_oport0;
  output_device output_device0(
    .clock      (clock),
    .we         (we_oport0),
    .wd         (WD),
    .rd         (RD_oport0),
    .oport      (oport0));
  
  //// input port0 $0xFF  
  wire        we_iport0;
  wire [7:0]  RD_iport0;
  input_device input_device0(
    .clock      (clock),
    .we         (we_iport0),
    .wd         (WD),
    .rd         (RD_iport0),
    .iport      (iport0)
    );
  
  
  //// address decoder
  //// $0x00 ~ $0xFD  : ram
  //// $xFE           : oport0
  //// $xFF           : iport0
  wire        sel_ram_io;
  wire        sel_o_i;
  wire [7:0]  RD_io;
  
  address_decoder address_decoder(
    .we         (we),
    .MA         (MA),
    .we_ram     (we_ram),
    .we_oport0  (we_oport0),
    .we_iport0  (we_iport0),
    .sel_ram_io (sel_ram_io),
    .sel_o_i    (sel_o_i));
    
  mux2 mux_o_i(
    .sel        (sel_o_i),
    .d0         (RD_oport0),
    .d1         (RD_iport0),
    .y          (RD_io));
    
  mux2 mux_ram_io(
    .sel        (sel_ram_io),
    .d0         (RD_ram),
    .d1         (RD_io),
    .y          (RD));
    
endmodule

  