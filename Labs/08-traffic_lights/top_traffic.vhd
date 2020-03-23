library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top_traffic is
port(
    clk_i    	: in  std_logic;
    srst_n_i 	: in  std_logic;    
	LED_o		: out std_logic_vector(5 downto 0)
	);
end entity top_traffic;


architecture Top_traffic of top_traffic is
    signal s_en  : std_logic;
begin


	CLK_EN_0 : entity work.clock_enable
    generic map(g_NPERIOD => x"0021")
    port map(clk_i => clk_i,
    		srst_n_i => srst_n_i,
            clock_enable_o => s_en);


	TRAFFIC_DRIVE : entity work.traffic
    port map(clk_i => clk_i,
    		cnt_en_i => s_en,
    		srst_n_i => srst_n_i,
            lights_o => LED_o);
            
end architecture Top_traffic;            
            
            