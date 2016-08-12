`default_nettype none

module prescaler(
  input wire  clock_src,    // 50 MHz
  output wire clock_lf,     // 3  Hz 
  output wire clock_hf      // 1.5KHz
  );
  
  reg [23:0] cnt;
  
  assign clock_lf = cnt[23];
  assign clock_hf = cnt[14];
  
  always @ (posedge clock_src) begin
    cnt <= cnt + 1'b1;
  end
  
  
endmodule
  