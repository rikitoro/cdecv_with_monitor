`default_nettype none

module top(
  // monitor
  input wire        clock_src_monitor,  // 50MHz clock
  input wire        reset_n_monitor,    // KEY4
  // CDECv
  input wire        clock_src,          // KEY3
  input wire        reset_n_0,          // KEY3
  // CDECv IO
  input wire  [3:0] iport_sw,           // SW3-0
  output      [7:0] oport_led,          // LEDR7-0 
 // debug monitor
  input wire  [3:0] dbg_addr_sw,        // SW6-4
  output wire [6:0] dbg_data_hex1,      // HEX1
  output wire [6:0] dbg_data_hex0,      // HEX0
  output wire       end_sq_led,
  output wire       halt_led,
  // monitor <-> PC (serial)
  input wire        uart_rxd,           // GPIO 0 pin 36
  output wire       uart_txd            // GIPO 0 pin 38
  );
  
  wire        clock;
  wire        reset_0;  // manual reset
  wire        reset_1;  // reset from monitor
  wire        reset;    // reset to CDECv   
  assign clock    = clock_src;
  assign reset_0  = ~reset_n_0;
  assign reset    = reset_0 | reset_1;
  
 // datapath <=> memory
  wire [7:0]  RD;
  wire [7:0]  MA;
  wire [7:0]  WD;

  // datapath <=> controller
  wire [2:0]  xsrc;
  wire [9:0]  xdst;
  wire [4:0]  aluop;
  wire [7:0]  I;
  wire [2:0]  SZCy;
  
  // controller -> memory
  wire        we;
  
  // controller -> system
  wire        end_sq;
  wire        halt;
  assign end_sq_led = end_sq;
  assign halt_led   = halt;
  
  // dbg_monitor (DE0 interface)
  wire [2:0] dbg_addr;
  wire [7:0] dbg_data;
  assign dbg_addr = dbg_addr_sw[2:0];
  hex_display hex_display1(
    .d    (dbg_data[7:4]),
    .hex  (dbg_data_hex1));
  hex_display hex_display0(
    .d    (dbg_data[3:0]),
    .hex  (dbg_data_hex0));
    
  
  /////////////////////////////////////////////////
  
  datapath datapath(
    .clock      (clock),
    .reset      (reset),
    // datapath <-> memory
    .RD         (RD),
    .MA         (MA),  
    .WD         (WD),
    // datapath <-> control unit
    .xsrc       (xsrc),     // read {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
    .xdst       (xdst),     // write enable {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC} 
    .aluop      (aluop),    // select alu operation
    .I          (I),
    .SZCy       (SZCy),     // from FLG {S, Z, Cy}
    // debug monitor
    .dbg_addr   (dbg_addr), // {7:FF, 6:Xbus, 5:R, 4:T, 3:C, 2:B, 1:A, 0:PC}
    .dbg_data   (dbg_data)
  );


  controller controller (
    .clock      (clock),
    .reset      (reset),
    // controller <=> datapath
    .I          (I),
    .SZCy       (SZCy),
    .xsrc       (xsrc),     // read {7:FF, 6:FLG, 5:R, 4:RD, 3:C, 2:B, 1:A, 0:PC}
    .xdst       (xdst),     // write enable {9:FLG, 8:R, 7:T, 6:I, 5:WD, 4:MA, 3:C, 2:B, 1:A, 0:PC} 
    .aluop      (aluop),    // select alu operation
    // memory write enable
    .we         (we),
  // end sequence
    .end_sq     (end_sq),
  // halt signal
    .halt       (halt)
  );
  
  ////
  wire        prg_clock;
  wire        prg_we;
  wire  [7:0] prg_MA;
  wire  [7:0] prg_WD;
  wire  [7:0] prg_RD;
  wire  [7:0] oport0;
  wire  [7:0] iport0;
  assign iport0 = {4'b0000, iport_sw};
  assign oport_led = oport0;
  
  memory memory(
    .clock      (clock),
    .we         (we),
    .MA         (MA),
    .WD         (WD),
    .RD         (RD),
  //
    .prg_clock  (prg_clock),
    .prg_we     (prg_we),
    .prg_MA     (prg_MA),
    .prg_WD     (prg_WD),
    .prg_RD     (prg_RD),
  //
    .oport0     (oport0),
    .iport0     (iport0)
    );
    
    

  //// monitor
  
  
  monitor monitor (
    .clk_clk          (clock_src_monitor),  //       clk.clk
    .reset_reset_n    (reset_n_monitor),    //     reset.reset_n
    .prg_ma_export    (prg_MA),             //    prg_ma.export
    .prg_wd_export    (prg_WD),             //    prg_wd.export
    .prg_rd_export    (prg_RD),             //    prg_rd.export
    .prg_clock_export (prg_clock),          // prg_clock.export
    .prg_we_export    (prg_we),             //    prg_we.export
    .reset_1_export   (reset_1),            //   reset_1.export
    .uart_rxd         (uart_rxd),           //      uart.rxd
    .uart_txd         (uart_txd)            //          .txd
    );

    
endmodule
