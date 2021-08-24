----------------------------------------------------------------------------
-- File name   : test_phase_accum.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : Testbench for phase accumulator
--
-- Author(s)   : Nash Reilly
--
-- Date        : August 13, 2021
--
-- Note(s)     : Tests phase_accum.vhd
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity test_phase_accum is
end entity test_phase_accum;

architecture test_phase_accum_arch of test_phase_accum is

  constant t_clk_per : time := 10 ns; -- Period of a 100MHZ Clock

  component phase_accum is
    port (
      clock       : in    std_logic;
      reset       : in    std_logic;
      freq_sel    : in    std_logic;
      phase_sel   : in    std_logic;
      freq0_tune  : in    std_logic_vector(31 downto 0);
      freq1_tune  : in    std_logic_vector(31 downto 0);
      phase0_tune : in    std_logic_vector(15 downto 0);
      phase1_tune : in    std_logic_vector(15 downto 0);
      phase_out   : out   std_logic_vector(31 downto 0)
    );
  end component;

  signal clock_tb      : std_logic;
  signal reset_tb      : std_logic;
  signal tb_freq_sel   : std_logic;
  signal tb_phase_sel  : std_logic;
  signal freq0_tune_tb : std_logic_vector(31 downto 0);
  signal freq1_tune_tb : std_logic_vector(31 downto 0);
  signal phase0_tune_tb : std_logic_vector(15 downto 0);
  signal phase1_tune_tb : std_logic_vector(15 downto 0);
  signal phase_out_tb  : std_logic_vector(31 downto 0);

  signal i : integer;

begin

  --Component Declaration

  dut1 : component phase_accum
    port map (
      clock       => clock_tb,
      reset       => reset_tb,
      freq_sel    => tb_freq_sel,
      phase_sel   => tb_phase_sel,
      freq0_tune  => freq0_tune_tb,
      freq1_tune  => freq1_tune_tb,
      phase0_tune => phase0_tune_tb,
      phase1_tune => phase1_tune_tb,
      phase_out   => phase_out_tb
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

    freq0_tune_tb  <= x"05F5E100";
    phase0_tune_tb <= x"0000";
    freq1_tune_tb  <= x"0BEBC200";
    phase1_tune_tb <= x"8000";
    tb_freq_sel       <= '0';
    tb_phase_sel      <= '0';
    wait for 100000 * t_clk_per;
    tb_freq_sel       <= '1';
    freq0_tune_tb  <= x"17D78400";
    wait for 100000 * t_clk_per;
    tb_phase_sel      <= '1';
    wait for 100000 * t_clk_per;
    wait;

  end process data_stim;

end architecture test_phase_accum_arch;


