
module monitor (
	clk_clk,
	clock_to_cdecv_export,
	dbg_addr_export,
	dbg_clock_export,
	dbg_data_export,
	dbg_we_export,
	prg_clock_export,
	prg_ma_export,
	prg_rd_export,
	prg_wd_export,
	prg_we_export,
	reset_reset_n,
	reset_to_cdecv_export,
	uart_rxd,
	uart_txd);	

	input		clk_clk;
	output		clock_to_cdecv_export;
	output	[3:0]	dbg_addr_export;
	input		dbg_clock_export;
	input	[15:0]	dbg_data_export;
	input		dbg_we_export;
	output		prg_clock_export;
	output	[7:0]	prg_ma_export;
	input	[7:0]	prg_rd_export;
	output	[7:0]	prg_wd_export;
	output		prg_we_export;
	input		reset_reset_n;
	output		reset_to_cdecv_export;
	input		uart_rxd;
	output		uart_txd;
endmodule
