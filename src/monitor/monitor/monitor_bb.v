
module monitor (
	clk_clk,
	reset_reset_n,
	prg_ma_export,
	prg_wd_export,
	prg_rd_export,
	prg_clock_export,
	prg_we_export,
	reset_1_export,
	uart_rxd,
	uart_txd);	

	input		clk_clk;
	input		reset_reset_n;
	output	[7:0]	prg_ma_export;
	output	[7:0]	prg_wd_export;
	input	[7:0]	prg_rd_export;
	output		prg_clock_export;
	output		prg_we_export;
	output		reset_1_export;
	input		uart_rxd;
	output		uart_txd;
endmodule
