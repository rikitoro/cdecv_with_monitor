	component monitor is
		port (
			clk_clk          : in  std_logic                    := 'X';             -- clk
			reset_reset_n    : in  std_logic                    := 'X';             -- reset_n
			prg_ma_export    : out std_logic_vector(7 downto 0);                    -- export
			prg_wd_export    : out std_logic_vector(7 downto 0);                    -- export
			prg_rd_export    : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			prg_clock_export : out std_logic;                                       -- export
			prg_we_export    : out std_logic;                                       -- export
			reset_1_export   : out std_logic;                                       -- export
			uart_rxd         : in  std_logic                    := 'X';             -- rxd
			uart_txd         : out std_logic                                        -- txd
		);
	end component monitor;

	u0 : component monitor
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --       clk.clk
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --     reset.reset_n
			prg_ma_export    => CONNECTED_TO_prg_ma_export,    --    prg_ma.export
			prg_wd_export    => CONNECTED_TO_prg_wd_export,    --    prg_wd.export
			prg_rd_export    => CONNECTED_TO_prg_rd_export,    --    prg_rd.export
			prg_clock_export => CONNECTED_TO_prg_clock_export, -- prg_clock.export
			prg_we_export    => CONNECTED_TO_prg_we_export,    --    prg_we.export
			reset_1_export   => CONNECTED_TO_reset_1_export,   --   reset_1.export
			uart_rxd         => CONNECTED_TO_uart_rxd,         --      uart.rxd
			uart_txd         => CONNECTED_TO_uart_txd          --          .txd
		);

