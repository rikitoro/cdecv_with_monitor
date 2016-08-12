
module monitor (
	clk_clk,
	prg_clock_export,
	prg_ma_export,
	prg_rd_export,
	prg_wd_export,
	prg_we_export,
	reset_reset_n,
	reset_1_export,
	uart_rxd,
	uart_txd,
	clock_1_export);	

	input		clk_clk;
	output		prg_clock_export;
	output	[7:0]	prg_ma_export;
	input	[7:0]	prg_rd_export;
	output	[7:0]	prg_wd_export;
	output		prg_we_export;
	input		reset_reset_n;
	output		reset_1_export;
	input		uart_rxd;
	output		uart_txd;
	output		clock_1_export;
endmodule
