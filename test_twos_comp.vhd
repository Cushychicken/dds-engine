------------------------------------------------------------------------------------------------------------
-- File name   : memory_interface.vhd
--
-- Project     : EELE367 - Logic Design
--               
-- Description : VHDL model of a 16 x 8-bit ROM memory system that has been initialized
--
-- Author(s)   : Nash Reilly
--
-- Date        : April 11, 2011
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

entity test_rom is
end entity test_rom;

architecture test_rom_arch of test_rom is

  constant t_clk_per : time := 20 ns;  -- Period of a 50MHZ Clock
  
  component rom_16x8_sync
    port (clock   : in  std_logic;
          enable  : in  std_logic;
          address : in  std_logic_vector(3 downto 0);
          data    : out std_logic_vector(7 downto 0));
  end component;

  signal  Clock_TB     : STD_LOGIC;
  signal  Enable_TB    : STD_LOGIC;
  signal  Address_TB   : STD_LOGIC_VECTOR(3 downto 0);
  signal  Data_TB      : STD_LOGIC_VECTOR(7 downto 0);
  
  begin
  
  --Component Declaration
    
    DUT1: rom_16x8_sync port map (clock   => Clock_TB, 
                                  enable  => Enable_TB,
                                  address => Address_TB,
                                  data    => Data_TB);
   
    CLOCK_STIM : process
       begin
          Clock_TB <= '0'; wait for 0.5*t_clk_per; 
          Clock_TB <= '1'; wait for 0.5*t_clk_per; 
       end process CLOCK_STIM;
       
    ENABLE_STIM : process
      begin
        Enable_TB <= '1'; wait for 2*t_clk_per;
        Enable_TB <= '0'; wait for 1*t_clk_per;
      end process ENABLE_STIM;
    
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
      end process;
      
    end architecture;
        
        