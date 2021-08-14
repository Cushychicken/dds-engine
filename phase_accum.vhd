----------------------------------------------------------------------------
-- File name   : phase_accum.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : 32 bit phase  accumulator for DDS engine
--
-- Author(s)   : Nash Reilly (cushychicken@gmail.com)
--
-- Date        : Friday, August 13, 2021
--
-- Note(s)     :
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity phase_accum is
  port (
    clock      : in    std_logic;
    reset      : in    std_logic;
    freq0_tune : in    std_logic_vector(15 downto 0);
    phase_out  : out   std_logic_vector(31 downto 0)
  );
end entity phase_accum;

architecture phase_accum_arch of phase_accum is

  signal phase_temp : std_logic_vector(31 downto 0);

begin

  accumulator : process (clock, reset) is
  begin

    if (reset = '0') then
      phase_out  <= x"00000000";
      phase_temp <= x"00000000";
    elsif (clock'event and clock='1') then
      phase_temp <= freq0_tune + phase_temp;
      phase_out  <= phase_temp;
    end if;

  end process accumulator;

end architecture phase_accum_arch;

