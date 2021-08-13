----------------------------------------------------------------------------
-- File name   : twos_comp.vhd
--
-- Project     : cushychicken/dds-engine
--               
-- Description : Testbench - two's comp block
--
-- Author(s)   : Nash Reilly
--
-- Date        : August 12, 2021
--
-- Note(s)     : Tests twos_comp.vhd
-- 
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity test_twos_comp is
end entity test_twos_comp;

architecture test_twos_comp_arch of test_twos_comp is

	constant t_clk_per : time := 20 ns;  -- Period of a 50MHZ Clock
  
	component twos_comp
		port (Clock   : in  STD_LOGIC;
			  Reset	  : in	STD_LOGIC;
			  Comp	  : in  STD_LOGIC;
			  Data	  : in  STD_LOGIC_VECTOR(13 downto 0);
			  Output  : out STD_LOGIC_VECTOR(13 downto 0));
	end component;

	signal  Clock_TB	: STD_LOGIC;
	signal  Reset_TB	: STD_LOGIC;
	signal  Comp_TB		: STD_LOGIC;
	signal  Data_TB		: STD_LOGIC_VECTOR(13 downto 0);
	signal  Output_TB	: STD_LOGIC_VECTOR(13 downto 0);
  
	signal  i	: integer;

begin
  
  --Component Declaration
    
    DUT1: twos_comp port map (Clock		=> Clock_TB, 
                              Reset		=> Reset_TB,
							  Comp		=> Comp_TB,
							  Data		=> Data_TB,
                              Output	=> Output_TB);
   
    CLOCK_STIM : process
    begin
		Clock_TB <= '0'; wait for 0.5*t_clk_per; 
		Clock_TB <= '1'; wait for 0.5*t_clk_per; 

		-- Assertion ends simulation after 10ms
		assert now < 10 ms report "Simulation Finished." severity FAILURE;
    end process CLOCK_STIM;
       
    RESET_STIM : process
    begin
        Reset_TB <= '0'; wait for 2*t_clk_per;
        Reset_TB <= '1'; 
		wait;
    end process RESET_STIM;
    
    DATA_STIM : process
    begin
		Data_TB <= "00000000000000";
		Comp_TB <= '0';
		wait for 3*t_clk_per;
		while ( Data_TB < "11111111111111" ) loop
			Comp_TB <= '1';
			wait for t_clk_per;

			Data_TB <= (Data_TB + 1); 
			Comp_TB <= '0';
			wait for t_clk_per;
		end loop;
		wait;
    end process DATA_STIM;
      
end architecture;


