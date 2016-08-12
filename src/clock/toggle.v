`default_nettype none

module toggle(
  input wire  clock_src, 
  output reg  clock_out
  );
      
  always @ (posedge clock_src) begin
    clock_out <= ~clock_out;
  end
  
endmodule
  