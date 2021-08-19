---------------------------------------------------------------------------
-- File name   : mux_2in_1out.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : 2in, 1out mux to select freq/phase tuning words
--
-- Author(s)   : Nash Reilly (cushychicken@gmail.com)
--
-- Date        : Aug 18, 2021
--
-- Note(s)     :
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity mux_2in_1out is
  port (
    -- Clock/Reset
    i_clock : in    std_logic;
    i_reset : in    std_logic;

    -- Mux Select Line
    i_sel : in    std_logic;
    -- Mux Input Ports
    i_in0 : in    std_logic_vector(31 downto 0);
    i_in1 : in    std_logic_vector(31 downto 0);
    -- Mux Output Port
    o_out : out   std_logic_vector(31 downto 0)
  );
end entity mux_2in_1out;

architecture arch_mux of mux_2in_1out is

  -- Signals and constants here

begin

  mux : process (i_clock, i_reset) is
  begin

    if (i_reset = '1') then
      o_out <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    elsif (i_clock'event and i_clock='1') then

      case (i_sel) is

        when '0' =>
          o_out <= i_in0;
        when '1' =>
          o_out <= i_in1;
        when others =>
          o_out <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

      end case;

    end if;

  end process mux;

end architecture arch_mux;
