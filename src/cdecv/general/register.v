`default_nettype none

/////

module register_r ( // positive edge clock, with reset
  input wire        clock,
  input wire        reset,
  input wire        we,
  input wire [7:0]  d,
  output reg [7:0]  q
  );
  
  always @ (posedge clock, posedge reset) begin
    if (reset) begin
      q <= 8'h00;             // reset to zero
    end else if (we) begin
      q <= d;                 // write data
    end else begin
      q <= q;                 // keep
    end
  end
endmodule

/////

module register(  // positive edge clock, without reset
  input wire        clock,
  input wire        we,
  input wire  [7:0] d,
  output wire [7:0] q
  );
  
  register_r register_r(
    .clock  (clock),
    .reset  (1'b0),
    .we     (we),
    .d      (d),
    .q      (q)
    );
endmodule
