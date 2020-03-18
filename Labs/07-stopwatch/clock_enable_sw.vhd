------------------------------------------------------------------------
--
-- Generates clock enable signal.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for clock enable
------------------------------------------------------------------------
entity clock_enable_sw is
generic (
    g_NPERIOD : unsigned(16-1 downto 0)
);
port (
    clk_i          	: in  std_logic;
    srst_n_i       	: in  std_logic; -- Synchronous reset (active low)
    ce_100Hz_i		: in std_logic;
    clock_enable_o 	: out std_logic
);
end entity clock_enable_sw;

------------------------------------------------------------------------
-- Architecture declaration for clock enable
------------------------------------------------------------------------
architecture Behavioral of clock_enable_sw is
    signal s_count : unsigned(16-1 downto 0) := x"0000";
begin

    --------------------------------------------------------------------
    -- p_clk_enable:
    -- Generate clock enable signal instead of creating another clock 
    -- domain. By default enable signal is low and generated pulse is 
    -- always one clock long.
    --------------------------------------------------------------------
    p_clk_enable : process(clk_i, srst_n_i, ce_100Hz_i, clock_enable_o)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_count <= (others => '0');   -- Clear all bits
                clock_enable_o <= '0';
            else
            	if ce_100Hz_i = '1' then
                    if s_count >= (g_NPERIOD-1) then
                        s_count <= (others => '0');
                        clock_enable_o <= '1';
                    else
                        s_count <= s_count + x"0001";
                        clock_enable_o <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process p_clk_enable;

end architecture Behavioral;