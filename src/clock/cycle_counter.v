`default_nettype none

module cycle_counter(
  input wire          reset,
  input wire          pause,
  input wire          clock,
  output reg  [15:0]  count);
  
  always @ (posedge clock, posedge reset) begin
    if (reset) begin
      count <= 16'h0000;
    end else if (pause) begin
      count <= count;
    end else begin
      count <= count + 1'b1;
    end
  end
  
endmodule
  