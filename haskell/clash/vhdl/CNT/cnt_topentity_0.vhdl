-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.cnt_types.all;

entity cnt_topentity_0 is
  port(arg             : in boolean;
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out std_logic_vector(3 downto 0));
end;

architecture structural of cnt_topentity_0 is
begin
  cnt_upcounter_result : entity cnt_upcounter
    port map
      (s               => result
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,clk             => arg);
end;
