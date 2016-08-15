`default_nettype none

module top(
  // monitor(nios2) clock and reset
  input wire        clock_src_nios,     // 50MHz clock
  input wire        reset_n_nios,       // KEY4 (FPGA_RESET)
  // CDECv clock and reset
  input wire        reset_n_manual,     // KEY1
  // CDECv clock source
  input wire        clock_src,          // 50MHz clock
  input wire        clock_manual_src,   // KEY0
  input wire  [1:0] sel_clock_sw,       // SW9-8: clock selector
                                        //  00: manual(KEY0), 01: from monitor,
                                        //  10: Low freq    , 11: High freq
  // CDECv IO
  input wire  [3:0] iport_sw,           // SW3-0
  output      [7:0] oport_led,          // LEDR7-0
  // debug interface
  input wire  [3:0] dbg_addr_sw,        // SW6-4, show debug data on HEX3-0
                                        //  0000: PC  , 0001: A   , 0010: B     , 0011: C   ,
                                        //  0100: T   , 0101: R   , 0110: FLG   , 0111: Xbus,
                                        //  1000: MA  , 1001: WD  , 1010: RD    , 1011: I   , 
                                        //  1100: xsrc, 1101: xdst, 1110: aluop , 1111: cycle_count
  output wire [6:0] dbg_data_hex3,      // HEX3
  output wire [6:0] dbg_data_hex2,      // HEX2
  output wire [6:0] dbg_data_hex1,      // HEX1
  output wire [6:0] dbg_data_hex0,      // HEX0
  output wire       end_sq_led,         // LEDR8
  output wire       clock_led,          // LEDR9
  output wire [2:0] SZCy_led,           // HEX5_0, HEX5_6, HEX5_3 (S, Z, Cy)
  output wire       we_led,             // HEX4_3
  // monitor <-> PC (serial)
  input wire        uart_rxd,           // GPIO 0 pin 36
  output wire       uart_txd            // GIPO 0 pin 38
  );


  /////////////////////////////////////////////////

  // reset
  wire        reset;          // reset for CDECv
  wire        reset_manual;   // manual reset
  wire        reset_monitor;  // reset from monitor
  assign reset_manual = ~reset_n_manual;
  assign reset        = reset_manual | reset_monitor;
  
  // clock
  wire        clock;          // clock for CDEC v
  wire        clock_hf;       // high freq clock  (generated by prescaler)
  wire        clock_lf;       // low freq clock   (generated by prescaler)
  wire        clock_monitor;  // clock from monitor
  wire        clock_manual;   // generated by manual clock
  
  prescaler prescaler(
    .clock_src  (clock_src),
    .clock_hf   (clock_hf),   
    .clock_lf   (clock_lf));  
  toggle toggle(
    .clock_src  (clock_manual_src),
    .clock_out  (clock_manual));
    
  assign clock =  (sel_clock_sw == 2'b00) ? clock_manual  :
                  (sel_clock_sw == 2'b01) ? clock_monitor :
                  (sel_clock_sw == 2'b10) ? clock_lf      : // 1.5 kHz
                                            clock_hf      ; // 3   Hz

  // cycle counter
  wire  [15:0]  cycle_count;
  wire          pause_cc;
  
  cycle_counter cycle_counter(
    .reset  (reset),
    .pause  (pause_cc),
    .clock  (clock),
    .count  (cycle_count));

  // I/O port (DE0 interface) 
  wire  [7:0] oport0;
  wire  [7:0] iport0;
  
  assign iport0 = {4'b0000, iport_sw};
  assign oport_led = oport0;
 
  /////////////////////////////////////////////////
  
  // CDEC v : datapath + controller + memory
  
 // datapath <=> memory
  wire [7:0]  RD;
  wire [7:0]  MA;
  wire [7:0]  WD;
  // datapath <=> controller
  wire [2:0]  xsrc;
  wire [9:0]  xdst;
  wire [3:0]  aluop;
  wire [7:0]  I;
  wire [2:0]  SZCy;
  // controller -> memory
  wire        we;

  // for debug ingerface
  wire        end_sq;
  wire [2:0]  dbg_addr_dp;
  wire [7:0]  dbg_data_dp;
  assign dbg_addr_dp = dbg_addr_sw[2:0];
  
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
    // debug interface
    .dbg_addr   (dbg_addr_dp),
    .dbg_data   (dbg_data_dp)
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
    .pause_cc   (pause_cc)
  );
  
  // monitor <=> memory
  wire        prg_clock;
  wire        prg_we;
  wire  [7:0] prg_MA;
  wire  [7:0] prg_WD;
  wire  [7:0] prg_RD;
  
  
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
    

  //////////////////////////////////////////////////////////////
    

  // monitor (nios2)
  
  monitor monitor (
    .clk_clk          (clock_src_nios),     //       clk.clk
    .reset_reset_n    (reset_n_nios),       //     reset.reset_n
    .prg_ma_export    (prg_MA),             //    prg_ma.export
    .prg_wd_export    (prg_WD),             //    prg_wd.export
    .prg_rd_export    (prg_RD),             //    prg_rd.export
    .prg_clock_export (prg_clock),          // prg_clock.export
    .prg_we_export    (prg_we),             //    prg_we.export
    .reset_1_export   (reset_monitor),      //   reset_1.export
    .clock_1_export   (clock_monitor),      //   clock_1.export
    .uart_rxd         (uart_rxd),           //      uart.rxd
    .uart_txd         (uart_txd)            //          .txd
    );

    
  /////////////////////////////////////////////////////////////
  
  // debug interface (DE0 interface)
  
  // LEDRs
  assign clock_led  = clock;
  assign end_sq_led = end_sq;
  
  // SZCy (HEX5_0, 6, 3)
  assign SZCy_led = ~SZCy;
  
  // we
  assign we_led = ~we;
  
  // dbg data (HEX3-0, SW7-4) (DE0 interface)
  wire [15:0] dbg_data;
  wire [2:0]  dbg_addr_tp;
  wire [15:0] dbg_data_tp;

  assign dbg_addr_tp = dbg_addr_sw[2:0];
  mux8 #(16) mux_dbg_data_tp(
    .sel(dbg_addr_tp),
    .d0({ 8'b0000_0000        , MA}),
    .d1({ 8'b0000_0000        , WD}),
    .d2({ 8'b0000_0000        , RD}),
    .d3({ 8'b0000_0000        , I }),
    .d4({13'b0000_0000_0000_0 , xsrc}),
    .d5({ 6'b0000_00          , xdst}),
    .d6({11'b0000_0000_0000   , aluop}),
    .d7(cycle_count),
    .y(dbg_data_tp));

  assign dbg_data = (dbg_addr_sw[3] == 0) ? {8'b0000_0000, dbg_data_dp} : // datapath
                                            dbg_data_tp                 ; // top module
  hex_display hex_display3( // HEX3
    .d    (dbg_data[15:12]),
    .hex  (dbg_data_hex3));
  hex_display hex_display2( // HEX2
    .d    (dbg_data[11:8]),
    .hex  (dbg_data_hex2)); 
  hex_display hex_display1( // HEX1
    .d    (dbg_data[7:4]),
    .hex  (dbg_data_hex1));
  hex_display hex_display0( // HEX1
    .d    (dbg_data[3:0]),
    .hex  (dbg_data_hex0));

    
endmodule
