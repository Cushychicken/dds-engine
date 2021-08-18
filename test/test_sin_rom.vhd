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
  use ieee.std_logic_textio.all;

library std;
  use std.textio.all;

entity test_sin_rom is
end entity test_sin_rom;

architecture test_sin_rom_arch of test_sin_rom is

  -- Constant Values
  constant t_clk_per : time := 20 ns; -- Period of a 50MHZ Clock
  constant s_header : string := "addr_tb,data_tb"; -- For file

  -- Device Under Test
  component sin_rom is
    port (
      clock : in    std_logic;
      addr  : in    std_logic_vector(13 downto 0);
      data  : out   std_logic_vector(11 downto 0)
    );
  end component;

  -- Testbench Signals
  signal clock_tb : std_logic;
  signal addr_tb  : std_logic_vector(13 downto 0);
  signal data_tb  : std_logic_vector(11 downto 0);

  -- Input/Output Files for Analysis
  --file file_Input_Vectors : text;
  file file_Result_Vectors : TEXT;

begin

  --Component Declaration
  dut1 : component sin_rom
    port map (
      clock => clock_tb,
      addr  => addr_tb,
      data  => data_tb
    );

  -- Clock Generation
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

  -- Address / Input Data Generation
  addr_stim : process is
	variable v_Output_Line : line;
  begin
	file_open(file_Result_Vectors, "output_results.txt", write_mode);

	write(v_Output_Line, s_header);
	writeline(file_Result_Vectors, v_Output_Line);
    addr_tb   <= "00000000000000";
	write(v_Output_Line, addr_tb);
	write(v_Output_Line, ',');
	write(v_Output_Line, data_tb);
	writeline(file_Result_Vectors, v_Output_Line);
    wait for t_clk_per;
    while (true) loop
      addr_tb <= (addr_tb + 1);
      wait for t_clk_per;
	  -- Assertion ends simulation after 10ms
	  --report string(to_unsigned(addr_tb));
	  --report string(to_unsigned(data_tb));
	  write(v_Output_Line, addr_tb);
	  write(v_Output_Line, ',');
	  write(v_Output_Line, data_tb);
	  writeline(file_Result_Vectors, v_Output_Line);
	  assert now < 10 ms
	    report "Simulation Finished."
        severity FAILURE;

    end loop;
    wait;

  end process addr_stim;

end architecture test_sin_rom_arch;


