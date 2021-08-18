---------------------------------------------------------------------------
-- File name   : top_dds.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : Top level file - Direct Digital Synthesizer Block
--
-- Author(s)   : Nash Reilly (cushychicken@gmail.com)
--
-- Date        : August 18, 2021
--
-- Note(s)     :
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity top_dds is
  port (
    clock    : in    std_logic;
    reset    : in    std_logic;
    spi_cs_l : in    std_logic;
    spi_sck : in    std_logic;
    spi_mosi : in    std_logic;
    spi_miso : out   std_logic;
    dds_output : out std_logic_vector(11 downto 0);
  );
end entity top_dds;

architecture arch_top_dds of top_dds is
  
  -- Component Declaration

  component phase_accum
	port (
      clock      : in    std_logic;
	  reset      : in    std_logic;
	  freq0_tune : in    std_logic_vector(15 downto 0);
	  phase_out  : out   std_logic_vector(31 downto 0)
    );
  end component;

  component sin_rom
    port (
      clock : in    std_logic;
      addr  : in    std_logic_vector(13 downto 0);
      data  : out   std_logic_vector(11 downto 0)
    );
  end component;

  -- Signals and constants here
  signal phase_output : std_logic_vector(13 downto 0);

begin

  -- Component Instantiations
  ACC1 : phase_accum
    port map ( clock	=> clock,
			   reset	=> reset,
			   freq0_tune => temp, 
			   phase_out => phase_output);

  ROM1 : sin_rom 
    port map ( clock    => clock,
			   addr		=> phase_output,
			   data		=> dds_output);
			   

end architecture arch_top_dds;
