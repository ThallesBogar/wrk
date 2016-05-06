-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.mealy_types.all;

entity mealy_testbench is
  port(done : out boolean);
end;

architecture structural of mealy_testbench is
  signal finished        : boolean;
  signal system1000      : std_logic;
  signal system1000_rstn : std_logic;
  signal w3              : mealy_types.tup2;
  signal result          : signed(8 downto 0);
begin
  done <= finished;
  
  -- pragma translate_off
  process is
  begin
    system1000 <= '0';
    wait for 3 ns;
    while (not finished) loop
      system1000 <= not system1000;
      wait for 500 ns;
      system1000 <= not system1000;
      wait for 500 ns;
    end loop;
    wait;
  end process;
  -- pragma translate_on
  
  -- pragma translate_off
  system1000_rstn <= '0',
             '1' after 2 ns;
  -- pragma translate_on
  
  totest : entity mealy_topentity_0
    port map
      (system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,w3              => w3
      ,result          => result);
  
  w3 <= mealy_types.tup2'(signed'(0 to 8 => 'X'),signed'(0 to 8 => 'X'));
  
  finished <=
  -- pragma translate_off
              false,
  -- pragma translate_on
              true
  -- pragma translate_off
              after 100 ns
  -- pragma translate_on
              ;
end;
