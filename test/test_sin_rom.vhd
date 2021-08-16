----------------------------------------------------------------------------
-- File name   : test_sin_rom.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : Testbench for phase accumulator
--
-- Author(s)   : Nash Reilly
--
-- Date        : August 13, 2021
--
-- Note(s)     : Tests sin_rom.vhd
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity test_sin_rom is
end entity test_sin_rom;

architecture test_sin_rom_arch of test_sin_rom is

  constant t_clk_per : time := 20 ns; -- Period of a 50MHZ Clock

  component sin_rom_10bits_1024words is
    port (
      clock : in    std_logic;
      addr  : in    std_logic_vector(13 downto 0);
      data  : out   std_logic_vector(11 downto 0)
    );
  end component;

  signal clock_tb : std_logic;
  signal addr_tb  : std_logic_vector(13 downto 0);
  signal data_tb  : std_logic_vector(11 downto 0);

begin

  --Component Declaration

  dut1 : component sin_rom_10bits_1024words
    port map (
      clock => clock_tb,
      addr  => addr_tb,
      data  => data_tb
    );

  clock_stim : process is
  begin

    clock_tb <= '0';
    wait for 0.5 * t_clk_per;
    clock_tb <= '1';
    wait for 0.5 * t_clk_per;

    -- Assertion ends simulation after 10ms
    assert now < 1 ms
      report "Simulation Finished."
      severity FAILURE;

  end process clock_stim;

  addr_stim : process is
  begin

    addr_tb   <= "00000000000000";
    wait for t_clk_per;
    while (addr_tb < "11111111111111") loop
      addr_tb <= (addr_tb + 1);
      wait for t_clk_per;
    end loop;
    wait;

  end process addr_stim;

end architecture test_sin_rom_arch;


