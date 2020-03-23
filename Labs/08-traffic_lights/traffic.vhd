library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity traffic is
	port(
    	clk_i    	: in  std_logic; 
        srst_n_i   	: in  std_logic;
        cnt_en_i 	: in  std_logic;        
        lights_o	: out std_logic_vector(5 downto 0)
		);
end entity traffic;

architecture Traffic of traffic is
    type state_type is (red_green, red_yellow, red_red_1, green_red, yellow_red, red_red_2);
    
    signal s_state : state_type;
    signal s_count : unsigned(3 downto 0);
    
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";
begin
    
	p_traffic : process (clk_i, srst_n_i, cnt_en_i)    
    begin
		if rising_edge(clk_i) then
            if srst_n_i = '0' then
                s_state <= red_green;
                s_count <= x"0";
            elsif cnt_en_i = '1' then
                case s_state is
                    when red_green =>
                        if s_count < SEC5 then
                            s_state <= red_green;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_yellow;
                            s_count <= x"0";
                        end if;
                    when red_yellow =>
                        if s_count < SEC1 then
                            s_state <= red_yellow;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_red_1;
                            s_count <= x"0";
                        end if;    
                    when red_red_1 =>
                        if s_count < SEC1 then
                            s_state <= red_red_1;
                            s_count <= s_count + 1;
                        else
                            s_state <= green_red;
                            s_count <= x"0";
                        end if;
                    when green_red =>
                        if s_count < SEC5 then
                            s_state <= green_red;
                            s_count <= s_count + 1;
                        else
                            s_state <= yellow_red;
                            s_count <= x"0";
                        end if;    
                    when yellow_red =>
                        if s_count < SEC1 then
                            s_state <= yellow_red;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_red_2;
                            s_count <= x"0";
                        end if;   
                    when red_red_2 =>
                        if s_count < SEC1 then
                            s_state <= red_red_2;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_green;
                            s_count <= x"0";
                        end if;    
                    when others =>
                        s_state <= red_green;
                end case;
            end if;
        end if;    
    end process p_traffic;

	p_sig_to_led : process (s_state)
    begin
    	case s_state is
        	when red_green => lights_o <= "011110";
            when red_yellow => lights_o <= "011101";
            when red_red_1 => lights_o <= "011011";
            when green_red => lights_o <= "110011";
            when yellow_red => lights_o <= "101011";
            when red_red_2 => lights_o <= "011011";
            when others => lights_o <= "011110";
		end case;
	end process;
end Traffic;