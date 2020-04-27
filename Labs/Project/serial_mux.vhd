------------------------------------------------------------------------
-- aranges paralel data into serial burst
------------------------------------------------------------------------

--LIBRARIES
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Provides unsigned numerical computation


-- Entity declaration
entity serial_mux is

generic (
    g_NBITS_2 : unsigned(3 downto 0) := "1011";
    g_NBITS_1 : unsigned(3 downto 0) := "1010"
);
port (
    clk_i    	: in  std_logic;
    srst_n_i 	: in  std_logic;   -- Synchronous reset (active low)
    clk_en_i 	: in  std_logic;
    data_p_i	: in  std_logic_vector(7 downto 0);
    par_b_i		: in  std_logic;
    set_stopb_i	: in  std_logic;
    
    out_tx		: out std_logic
);
end entity serial_mux;


-- Architecture declaration
architecture Behavioral of serial_mux is
    signal s_cnt : unsigned(3 downto 0) := "0000";
begin

    
    ------------------------------------------------------------
    -- p_select_cnt:
    --------------------------------------------------------------------
    p_select_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  				-- Rising clock edge
            if srst_n_i = '0' then  				-- Synchronous reset (active low)
                s_cnt <= (others => '0');
            elsif clk_en_i = '1' then
                s_cnt <= s_cnt + "0001"; 
                if set_stopb_i = '1' then			--set_stopb_i = 1 means two stop bits in serial burst
                    if s_cnt = (g_NBITS_2) then
                        s_cnt <= (others => '0');
                    end if;
                elsif set_stopb_i = '0' then		--set_stopb_i = 0 means only 1 stop bit
                    if s_cnt = (g_NBITS_1) then
                        s_cnt <= (others => '0');
                    end if;
 				end if;
            end if;          
        end if;
    end process p_select_cnt;

    --------------------------------------------------------------------
    -- p_mux:
    --------------------------------------------------------------------
    p_mux : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                out_tx <= '0';
            elsif clk_en_i = '1' then
                case s_cnt is
                when x"0" =>
                    out_tx <= '0';			-- start bit
                when x"1" =>
                    out_tx <= data_p_i(0);	--data bits 0...7
                when x"2" =>
                    out_tx <= data_p_i(1);
                when x"3" =>  
					out_tx <= data_p_i(2);
                when x"4" => 
                    out_tx <= data_p_i(3);
                when x"5" => 
                    out_tx <= data_p_i(4);
                when x"6" => 
                    out_tx <= data_p_i(5);
                when x"7" =>                
                    out_tx <= data_p_i(6);
                when x"8" => 
                    out_tx <= data_p_i(7);
                when x"9" => 
                    out_tx <= par_b_i;		--parity bit
                when x"A" => 
                    out_tx <= '1';			--stop bit 1
                when x"B" => 	
                	out_tx <= '1';			--stop bit 2, when is it enabled
       			when others =>
                	out_tx <= '0';
                end case;
			end if;
        end if;        
    end process p_mux;

end architecture Behavioral;