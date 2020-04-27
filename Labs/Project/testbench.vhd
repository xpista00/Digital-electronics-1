------------------------------------------------------------------------
-- Testbench for top.vhd
------------------------------------------------------------------------

--LIBRARIES
LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY testbench IS
END testbench;
 
ARCHITECTURE tb OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
        clk_i    	: in  std_logic;	-- clock
        BTN0 		: in  std_logic;   	-- signal s_rst_n_i: Synchronous reset (active low)
        -- input of paralel data b0 ... b7
        SW0_CPLD, SW1_CPLD, SW2_CPLD, SW3_CPLD, SW4_CPLD, SW5_CPLD, SW6_CPLD, SW7_CPLD  : in  std_logic;	
        -----------------------   
        SW8_CPLD	: in  std_logic;	-- signal s_parity_i: sets parity odd = L/even = H
        SW9_CPLD	: in  std_logic;	-- signal set_stopb_i: sets quantity of stop bits H = 2b/ L = 1b
        SW10_CPLD	: in  std_logic;	-- signal set_speed_i: sets baud rate H = 4.8 kbps / L = 1.2 kbps

        LD0_CPLD	: out std_logic   	-- signal out_tx: serial output
    	);
    END COMPONENT;
    
	-- inputs
    signal clk_i    	: std_logic;	-- clock
    signal srst_n_i 	: std_logic;   	-- Synchronous reset (active low)
    signal data_p_i		: std_logic_vector(7 downto 0);	--input of paralel data
	signal s_parity_i	: std_logic;	-- sets parity odd = H/even = L
    signal set_stopb_i	: std_logic;	-- sets quantity of stop bits H = 2bits/ L = 1bit 
    signal set_speed_i	: std_logic;	-- sets baud rate H = 4.8 kbps / L = 1.2 kbps
    -- outputs    
    signal out_tx		: std_logic;   	-- serial output    
    
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   UUT: top PORT MAP (clk_i => clk_i,
                        BTN0 => srst_n_i,
                        SW0_CPLD => data_p_i(0),
                        SW1_CPLD => data_p_i(1),
                        SW2_CPLD => data_p_i(2),
                        SW3_CPLD => data_p_i(3),
                        SW4_CPLD => data_p_i(4),
                        SW5_CPLD => data_p_i(5),
                        SW6_CPLD => data_p_i(6),
                        SW7_CPLD => data_p_i(7),
                        SW8_CPLD => s_parity_i,
                        SW9_CPLD => set_stopb_i,
                        SW10_CPLD => set_speed_i,
                        LD0_CPLD => out_tx
                       	);
 

	Clk_gen: process
  	begin
    	while Now < 20 MS loop		-- using clk frequency 100 kHz of coolrunner
      		clk_i <= '0';
      		wait for 5 US;
      		clk_i <= '1';
      		wait for 5 US;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin
--        srst_n_i <= '0';
--        wait until rising_edge(clk_i);
        data_p_i <= "11111111";
        s_parity_i <= '1';
        set_speed_i <= '1';
        set_stopb_i	<= '1';	
        srst_n_i <= '1';
        wait for 4 MS;
        wait for 2 MS;
        data_p_i <= "10001111";
        wait for 2 MS;
        s_parity_i <= '0';
        wait for 2 MS;
        set_stopb_i	<= '0';
        wait for 2 MS;
        set_speed_i <= '0';
        wait;
        
        
        
    end process;

end tb;