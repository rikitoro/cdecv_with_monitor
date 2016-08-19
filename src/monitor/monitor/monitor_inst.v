	monitor u0 (
		.clk_clk               (<connected-to-clk_clk>),               //            clk.clk
		.clock_to_cdecv_export (<connected-to-clock_to_cdecv_export>), // clock_to_cdecv.export
		.dbg_addr_export       (<connected-to-dbg_addr_export>),       //       dbg_addr.export
		.dbg_clock_export      (<connected-to-dbg_clock_export>),      //      dbg_clock.export
		.dbg_data_export       (<connected-to-dbg_data_export>),       //       dbg_data.export
		.dbg_we_export         (<connected-to-dbg_we_export>),         //         dbg_we.export
		.prg_clock_export      (<connected-to-prg_clock_export>),      //      prg_clock.export
		.prg_ma_export         (<connected-to-prg_ma_export>),         //         prg_ma.export
		.prg_rd_export         (<connected-to-prg_rd_export>),         //         prg_rd.export
		.prg_wd_export         (<connected-to-prg_wd_export>),         //         prg_wd.export
		.prg_we_export         (<connected-to-prg_we_export>),         //         prg_we.export
		.reset_reset_n         (<connected-to-reset_reset_n>),         //          reset.reset_n
		.reset_to_cdecv_export (<connected-to-reset_to_cdecv_export>), // reset_to_cdecv.export
		.uart_rxd              (<connected-to-uart_rxd>),              //           uart.rxd
		.uart_txd              (<connected-to-uart_txd>)               //               .txd
	);

