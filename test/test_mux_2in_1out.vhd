----------------------------------------------------------------------------
-- File name   : test_mux_2in_1out.vhd
--
-- Project     : cushychicken/dds-engine
--
-- Description : Testbench - 32 bit multiplexer
--
-- Author(s)   : Nash Reilly
--
-- Date        : August 18, 2021
--
-- Note(s)     : Tests mux_2in_1out.vhd
--
----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.std_logic_arith.all;

entity test_mux_2in_1out is
end entity test_mux_2in_1out;

architecture test_mux_2in_1out_arch of test_mux_2in_1out is

  constant t_clk_per : time := 20 ns; -- Period of a 50MHZ Clock

  component mux_2in_1out is
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
  end component;

  -- Testbench Signals
  signal tb_clock  : std_logic;
  signal tb_reset  : std_logic;
  signal tb_sel    : std_logic;
  signal tb_in0    : std_logic_vector(31 downto 0);
  signal tb_in1    : std_logic_vector(31 downto 0);
  signal tb_output : std_logic_vector(31 downto 0);

begin

  --Component Declaration
  dut1 : component mux_2in_1out
    port map (
      i_clock => tb_clock,
      i_reset => tb_reset,
      i_sel   => tb_sel,
      i_in0   => tb_in0,
      i_in1   => tb_in1,
      o_out   => tb_output
    );

  clock_stim : process is
  begin

    tb_clock <= '0';
    wait for 0.5 * t_clk_per;
    tb_clock <= '1';
    wait for 0.5 * t_clk_per;

    -- Assertion ends simulation after 10ms
    assert now < 1 us
      report "Simulation Finished."
      severity FAILURE;

  end process clock_stim;

  reset_stim : process is
  begin

    tb_reset <= '1';
    wait for 2 * t_clk_per;
    tb_reset <= '0';
    wait;

  end process reset_stim;

  mux_stim : process is
  begin

    tb_in0 <= X"AAAA_AAAA";
    tb_in1 <= X"5555_5555";
    tb_sel <= '0';
    wait for 3 * t_clk_per;

    tb_sel <= '1';
    wait for 22 * t_clk_per;
    wait;

  end process mux_stim;

end architecture test_mux_2in_1out_arch;


