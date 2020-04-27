------------------------------------------------------------------------
-- Counts parity bit 1/0, from paralel input
------------------------------------------------------------------------

--LIBRARIES
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Provides unsigned numerical computation
------------------------------------------------------------------------


-- Entity declaration
entity parity_counter is
port (
    clk_i          	: in  std_logic;
    cnt_en_i		: in  std_logic;
    srst_n_i     	: in  std_logic; -- Synchronous reset (active low)
	s_parity_i		: in  std_logic;
    data_p_i		: in  std_logic_vector(7 downto 0);
    
    par_b_o			: out std_logic
);
end entity parity_counter;
------------------------------------------------------------------------

-- Architecture declaration for clock enable
architecture Behavioral of parity_counter is
 --   signal s_ones_sum : unsigned(15 downto 0) := x"0000";
 --   signal s_par_i : unsigned;
begin

    
	p_parity : process(clk_i)
	begin
		if rising_edge(clk_i) then
            if srst_n_i = '0' then
				--s_ones_sum <= x"0000";				--reset
				par_b_o <= '0';						--reset
            elsif cnt_en_i = '1' then	
                par_b_o <= ((((((((s_parity_i xor data_p_i(0)) xor data_p_i(1)) xor data_p_i(2))
                			xor data_p_i(3)) xor data_p_i(4)) xor data_p_i(5)) xor data_p_i(6)) 
                            xor data_p_i(7));                
                --s_ones_sum <= x"0000";				--resets sum before counting
                --s_ones_sum <= data_p_i(0) + data_p_i(1) + data_p_i(2) + data_p_i(3)	--sum of data bits
            	--		+ data_p_i(4) + data_p_i(5) + data_p_i(6) + data_p_i(7) + s_parity_i;		
               	--if (s_ones_sum mod 2) = 1 then			--declaration of parity bit
                --	par_b_o <= '0';
                --elsif (s_ones_sum mod 2) = 0 then
                --	par_b_o <= '1';
                --end if;
            end if;
        end if;
    end process p_parity;

end architecture Behavioral;