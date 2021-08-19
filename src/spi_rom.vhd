---------------------------------------------------------------------------
-- File name   : .vhd
--
-- Project     : 
--               
-- Description : 
--
-- Author(s)   : Nash Reilly (cushychicken@gmail.com)
--
-- Date        : 
--
-- Note(s)     : 
-- 
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity spi_rom is
	  port (
		-- Clock / Reset
		i_clock : in std_logic;
		i_reset : in std_logic;
		-- SPI bus
		i_spi_cs_l : in std_logic;
		i_spi_sck : in std_logic;
		i_spi_mosi : in std_logic;
		o_spi_miso : out std_logic;
		-- Control registers
		r_dds_ctrl : out std_logic_vector(7 downto 0);
		r_wave_select : out std_logic_vector(7 downto 0);
		r_freq0_tune : out std_logic_vector(31 downto 0);
		r_freq1_tune : out std_logic_vector(31 downto 0);
		r_phase0_tune : out std_logic_vector(11 downto 0);
		r_phase1_tune : out std_logic_vector(11 downto 0)
	    );
end entity spi_rom;

architecture  of  is

	  -- Signals and constants here 
	

	  begin 

	if (i_reset = '1') begin
		o_spi_miso <= '0';
		r_dds_ctrl <= X"00";
		r_wave_select <= X"00";
		r_freq0_tune <= X"0000_0000";
		r_freq1_tune <= X"0000_0000";
		r_phase0_tune <= X"000";
		r_phase1_tune <= X"000";
	elsif ( i_clock'event and i_clock = '1') begin
		if ( i_spi_cs_l = '0' ) then
	end if;

end architecture  ;
