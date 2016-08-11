`default_nettype none

/////

module io_device(
  input wire        clock,
  input wire        we,
  input wire  [7:0] wd,
  output wire [7:0] rd,
  //
  input wire  [7:0] iport,
  output wire [7:0] oport
  );

  register data(
    .clock  (clock),
    .we     (we),
    .d      (wd),
    .q      (oport)
  );
  
  assign rd = iport;
  
endmodule

/////

module input_device(
  input wire        clock,
  input wire        we,
  input wire  [7:0] wd,
  output wire [7:0] rd,
  //
  input wire  [7:0] iport
  );
  
  wire [7:0] oport;
  
  io_device i_device(
    .clock  (clock),
    .we     (we),
    .wd     (wd),
    .rd     (rd),
    .iport  (iport),
    .oport  (oport));
endmodule

/////

module output_device(
  input wire        clock,
  input wire        we,
  input wire  [7:0] wd,
  output wire [7:0] rd,
  //
  output wire [7:0] oport
  );
  
  wire [7:0] iport;
  
  io_device o_device(
    .clock  (clock),
    .we     (we),
    .wd     (wd),
    .rd     (rd),
    .iport  (iport),
    .oport  (iport));
    
  assign oport = iport;

endmodule
  