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
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity twos_comp is
	port (Clock   : in  STD_LOGIC;
		  Reset	  : in	STD_LOGIC;
		  Comp	  : in  STD_LOGIC;
		  Data	  : in  STD_LOGIC_VECTOR(13 downto 0);
		  Output  : out STD_LOGIC_VECTOR(13 downto 0));
end entity twos_comp;

architecture twos_comp_arch of twos_comp is

	signal Temp	: STD_LOGIC_VECTOR(13 downto 0);

begin
  
    input : process(Clock, Reset)
    begin
		Temp <= not Data;
		if (Reset = '0') then
			Output <= "00000000000000";
		elsif (Clock'event and Clock='1') then
			if (Comp = '0') then
				Output <= Data;
			else 
				Output <= STD_LOGIC_VECTOR(unsigned(Temp) + 1);
			end if;
		end if;
	end process input;
       
end architecture;
        
        
