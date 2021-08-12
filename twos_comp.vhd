------------------------------------------------------------------------------------------------------------
-- File name   : memory_interface.vhd
--
-- Project     : cushychicken/dds-engine
--               
-- Description : Testbench - two's comp block
--
-- Author(s)   : Nash Reilly
--
-- Date        : August 12, 2021
--
-- Note(s)     : Data load register
-- 
--              Address      Description
--              ----------------------------------
--              $0           
--               :           Read Only Memory 
--              $F            (16x8-bit)              
--
------------------------------------------------------------------------------------------------------------

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
			  Reset	  : in	STD_LOGIC
			  Comp	  : in  STD_LOGIC;
			  Data	  : in  STD_LOGIC_VECTOR(13 downto 0);
			  Output  : out STD_LOGIC_VECTOR(13 downto 0));
	end component;

	signal  Clock_TB	: STD_LOGIC;
	signal  Reset_TB	: STD_LOGIC;
	signal  Comp_TB		: STD_LOGIC;
	signal  Data_TB		: STD_LOGIC_VECTOR(13 downto 0);
	signal  Output_TB	: STD_LOGIC_VECTOR(13 downto 0);
  
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
    end process CLOCK_STIM;
       
    RESET_STIM : process
    begin
        Reset_TB <= '0'; wait for 2*t_clk_per;
        Reset_TB <= '1'; 
		wait;
    end process RESET_STIM;
    
    ADDRESS_STIM : process
    begin
        Address_TB <= "0000"; wait for 3*t_clk_per;
        Address_TB <= "0001"; wait for 3*t_clk_per;
        Address_TB <= "0010"; wait for 3*t_clk_per;
        Address_TB <= "0011"; wait for 3*t_clk_per;
        Address_TB <= "0100"; wait for 3*t_clk_per;
        Address_TB <= "0101"; wait for 3*t_clk_per;
        Address_TB <= "0110"; wait for 3*t_clk_per;
        Address_TB <= "0111"; wait for 3*t_clk_per;
        Address_TB <= "1000"; wait for 3*t_clk_per;
        Address_TB <= "1001"; wait for 3*t_clk_per;
        Address_TB <= "1010"; wait for 3*t_clk_per;
        Address_TB <= "1011"; wait for 3*t_clk_per;
        Address_TB <= "1100"; wait for 3*t_clk_per;
        Address_TB <= "1101"; wait for 3*t_clk_per;
        Address_TB <= "1110"; wait for 3*t_clk_per;
        Address_TB <= "1111"; wait for 3*t_clk_per;
		wait;
    end process ADDRESS_STIM;
      
end architecture;
        
        
