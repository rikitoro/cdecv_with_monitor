	component monitor is
		port (
			clk_clk               : in  std_logic                     := 'X';             -- clk
			clock_to_cdecv_export : out std_logic;                                        -- export
			dbg_addr_export       : out std_logic_vector(3 downto 0);                     -- export
			dbg_clock_export      : in  std_logic                     := 'X';             -- export
			dbg_data_export       : in  std_logic_vector(15 downto 0) := (others => 'X'); -- export
			dbg_we_export         : in  std_logic                     := 'X';             -- export
			prg_clock_export      : out std_logic;                                        -- export
			prg_ma_export         : out std_logic_vector(7 downto 0);                     -- export
			prg_rd_export         : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			prg_wd_export         : out std_logic_vector(7 downto 0);                     -- export
			prg_we_export         : out std_logic;                                        -- export
			reset_reset_n         : in  std_logic                     := 'X';             -- reset_n
			reset_to_cdecv_export : out std_logic;                                        -- export
			uart_rxd              : in  std_logic                     := 'X';             -- rxd
			uart_txd              : out std_logic;                                        -- txd
			dbg_end_sq_export     : in  std_logic                     := 'X'              -- export
		);
	end component monitor;

	u0 : component monitor
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --            clk.clk
			clock_to_cdecv_export => CONNECTED_TO_clock_to_cdecv_export, -- clock_to_cdecv.export
			dbg_addr_export       => CONNECTED_TO_dbg_addr_export,       --       dbg_addr.export
			dbg_clock_export      => CONNECTED_TO_dbg_clock_export,      --      dbg_clock.export
			dbg_data_export       => CONNECTED_TO_dbg_data_export,       --       dbg_data.export
			dbg_we_export         => CONNECTED_TO_dbg_we_export,         --         dbg_we.export
			prg_clock_export      => CONNECTED_TO_prg_clock_export,      --      prg_clock.export
			prg_ma_export         => CONNECTED_TO_prg_ma_export,         --         prg_ma.export
			prg_rd_export         => CONNECTED_TO_prg_rd_export,         --         prg_rd.export
			prg_wd_export         => CONNECTED_TO_prg_wd_export,         --         prg_wd.export
			prg_we_export         => CONNECTED_TO_prg_we_export,         --         prg_we.export
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --          reset.reset_n
			reset_to_cdecv_export => CONNECTED_TO_reset_to_cdecv_export, -- reset_to_cdecv.export
			uart_rxd              => CONNECTED_TO_uart_rxd,              --           uart.rxd
			uart_txd              => CONNECTED_TO_uart_txd,              --               .txd
			dbg_end_sq_export     => CONNECTED_TO_dbg_end_sq_export      --     dbg_end_sq.export
		);

