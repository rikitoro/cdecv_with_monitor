	monitor u0 (
		.clk_clk          (<connected-to-clk_clk>),          //       clk.clk
		.prg_clock_export (<connected-to-prg_clock_export>), // prg_clock.export
		.prg_ma_export    (<connected-to-prg_ma_export>),    //    prg_ma.export
		.prg_rd_export    (<connected-to-prg_rd_export>),    //    prg_rd.export
		.prg_wd_export    (<connected-to-prg_wd_export>),    //    prg_wd.export
		.prg_we_export    (<connected-to-prg_we_export>),    //    prg_we.export
		.reset_reset_n    (<connected-to-reset_reset_n>),    //     reset.reset_n
		.reset_1_export   (<connected-to-reset_1_export>),   //   reset_1.export
		.uart_rxd         (<connected-to-uart_rxd>),         //      uart.rxd
		.uart_txd         (<connected-to-uart_txd>),         //          .txd
		.clock_1_export   (<connected-to-clock_1_export>)    //   clock_1.export
	);

