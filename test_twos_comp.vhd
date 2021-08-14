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

  constant t_clk_per : time := 20 ns; -- Period of a 50MHZ Clock

  component twos_comp is
    port (
      clock  : in    std_logic;
      reset  : in    std_logic;
      comp   : in    std_logic;
      data   : in    std_logic_vector(13 downto 0);
      output : out   std_logic_vector(13 downto 0)
    );
  end component;

  signal clock_tb  : std_logic;
  signal reset_tb  : std_logic;
  signal comp_tb   : std_logic;
  signal data_tb   : std_logic_vector(13 downto 0);
  signal output_tb : std_logic_vector(13 downto 0);

  signal i : integer;

begin

  --Component Declaration

  dut1 : component twos_comp
    port map (
      clock  => clock_tb,
      reset  => reset_tb,
      comp   => comp_tb,
      data   => data_tb,
      output => output_tb
    );

  clock_stim : process is
  begin

    clock_tb <= '0';
    wait for 0.5 * t_clk_per;
    clock_tb <= '1';
    wait for 0.5 * t_clk_per;

    -- Assertion ends simulation after 10ms
    assert now < 10 ms
      report "Simulation Finished."
      severity FAILURE;

  end process clock_stim;

  reset_stim : process is
  begin

    reset_tb <= '0';
    wait for 2 * t_clk_per;
    reset_tb <= '1';
    wait;

  end process reset_stim;

  data_stim : process is
  begin

    data_tb   <= "00000000000000";
    comp_tb   <= '0';
    wait for 3 * t_clk_per;
    while (data_tb < "11111111111111") loop
      comp_tb <= '1';
      wait for t_clk_per;

      data_tb <= (data_tb + 1);
      comp_tb <= '0';
      wait for t_clk_per;
    end loop;
    wait;

  end process data_stim;

end architecture test_twos_comp_arch;


