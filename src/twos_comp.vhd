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
  port (
    clock : in    std_logic;
    reset : in    std_logic;
    comp  : in    std_logic;
    data  : in    std_logic_vector(13 downto 0);
    output : out   std_logic_vector(13 downto 0)
  );
end entity twos_comp;

architecture twos_comp_arch of twos_comp is

  signal temp : std_logic_vector(13 downto 0);

begin

  input : process (Clock, Reset) is
  begin

    temp <= not Data;

    if (reset = '0') then
      output <= "00000000000000";
    elsif (clock'event and clock='1') then
      if (comp = '0') then
        output <= data;
      else
        output <= std_logic_vector(unsigned(temp) + 1);
      end if;
    end if;

  end process input;

end architecture twos_comp_arch;


