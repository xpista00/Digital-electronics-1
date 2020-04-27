------------------------------------------------------------------------
-- Top
------------------------------------------------------------------------

--LIBRARIES
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------


-- Entity declaration
entity top is
port(
    clk_i    	: in  std_logic;	-- clock
    BTN0 		: in  std_logic;   	-- signal s_rst_n_i: Synchronous reset (active low)
    -- input of paralel data b0 ... b7
    SW0_CPLD, SW1_CPLD, SW2_CPLD, SW3_CPLD, SW4_CPLD, SW5_CPLD, SW6_CPLD, SW7_CPLD  : in  std_logic;	
    -----------------------   
	SW8_CPLD	: in  std_logic;	-- signal s_parity_i: sets parity odd = L/even = H
    SW9_CPLD	: in  std_logic;	-- signal set_stopb_i: sets quantity of stop bits H = 2bits/ L = 1bit 
    SW10_CPLD	: in  std_logic;	-- signal set_speed_i: sets baud rate H = 4.8 kbps / L = 1.2 kbps
    
    LD0_CPLD	: out std_logic   	-- signal out_tx: serial output
    );
end entity top;
------------------------------------------------------------------------

-- Architecture declaration for clock enable
architecture Behavioral of top is
    signal s_en 	:  std_logic;
	signal s_parb	:  std_logic; 
begin

	ENABLE_CLOCK : entity work.clock_enable
    	port map(clk_i => clk_i,
    			srst_n_i => BTN0,
  				set_speed_i => SW10_CPLD,
    			clock_enable_o => s_en);
                
                
    COUNT_PARITY : entity work.parity_counter
    	port map(clk_i => clk_i,
    			srst_n_i => BTN0,
  				cnt_en_i => s_en,
                s_parity_i => SW8_CPLD,
                data_p_i(0) => SW0_CPLD,
                data_p_i(1) => SW1_CPLD,
                data_p_i(2) => SW2_CPLD,
                data_p_i(3) => SW3_CPLD,
                data_p_i(4) => SW4_CPLD,
                data_p_i(5) => SW5_CPLD,
                data_p_i(6) => SW6_CPLD,
                data_p_i(7) => SW7_CPLD,
                par_b_o => s_parb);         


	MULTIPLEXER : entity work.serial_mux
    	port map(clk_i => clk_i,
    			srst_n_i => BTN0,
  				clk_en_i => s_en,
                data_p_i(0) => SW0_CPLD,
                data_p_i(1) => SW1_CPLD,
                data_p_i(2) => SW2_CPLD,
                data_p_i(3) => SW3_CPLD,
                data_p_i(4) => SW4_CPLD,
                data_p_i(5) => SW5_CPLD,
                data_p_i(6) => SW6_CPLD,
                data_p_i(7) => SW7_CPLD,
                par_b_i => s_parb,
                set_stopb_i => SW9_CPLD,
                out_tx => LD0_CPLD);
    
    
end architecture Behavioral;    