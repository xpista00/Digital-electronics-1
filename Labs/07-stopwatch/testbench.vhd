LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE tb OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
    clk_i    : in  std_logic;
    cnt_en_i : in  std_logic;
    ce_100Hz_i: in std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
	);
    END COMPONENT;
    
	-- inputs
    signal clk_i    : std_logic;
    signal srst_n_i : std_logic; 
    signal cnt_en_i : std_logic;
    signal ce_100Hz_i: std_logic := '1';
    signal dp_i     : std_logic_vector(4-1 downto 0) := "1101";  -- Decimal points
   -- outputs
	    
    signal dp_o     : std_logic;                       -- Decimal point
    signal seg_o    : std_logic_vector(7-1 downto 0);
    signal dig_o    : std_logic_vector(4-1 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   UUT: top PORT MAP (clk_i => clk_i,
   						cnt_en_i => cnt_en_i,
                        ce_100Hz_i => ce_100Hz_i,
                        srst_n_i => srst_n_i,
                        dp_i => dp_i,
                        dp_o => dp_o,
                        seg_o => seg_o,
                        dig_o => dig_o);

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--	;	<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 


	Clk_gen: process	-- NEW
  	begin
    	while Now < 5000 NS loop		-- NEW: DEFINE SIMULATION TIME
      		clk_i <= '0';
      		wait for 0.5 NS;
      		clk_i <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;

    -- Stimulus process
    stim_proc: process
    begin
        srst_n_i <= '1';
        cnt_en_i <= '1';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        cnt_en_i <= '0';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        cnt_en_i <= '1';
        wait for 970 NS;
        srst_n_i <= '0';
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        wait until rising_edge(clk_i);
        srst_n_i <= '1';
        wait;
    end process;

end tb;