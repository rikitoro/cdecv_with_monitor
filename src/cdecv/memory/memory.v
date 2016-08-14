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
  
  
  //// ram $0x00~0xFE  
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

  //// IO port0 $0xFF  
  wire        we_io;
  wire [7:0]  RD_io;

  io_device io_device0(
    .clock      (clock),
    .we         (we_io),
    .wd         (WD),
    .rd         (RD_io),
    .iport      (iport0),
    .oport      (oport0)
    );
  
  
  //// address decoder
  //// $0x00 ~ $0xFE  : ram
  //// $xFF           : IOport0
  wire        sel_ram_io;
  address_decoder address_decoder(
    .we         (we),
    .MA         (MA),
    .we_ram     (we_ram),
    .we_io      (we_io),
    .sel_ram_io (sel_ram_io),
    );
    
  mux2 mux_ram_io(
    .sel        (sel_ram_io),
    .d0         (RD_ram),
    .d1         (RD_io),
    .y          (RD));
    
endmodule
