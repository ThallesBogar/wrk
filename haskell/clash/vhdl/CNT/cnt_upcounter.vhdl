-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.cnt_types.all;

entity cnt_upcounter is
  port(clk             : in boolean;
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       s               : out std_logic_vector(3 downto 0));
end;

architecture structural of cnt_upcounter is
  signal x      : std_logic_vector(3 downto 0);
  signal result : std_logic_vector(3 downto 0);
  signal s_rec  : std_logic_vector(3 downto 0);
begin
  x <= std_logic_vector(unsigned(s_rec) + unsigned(std_logic_vector'("0001")));
  
  result <= x when clk else
            s_rec;
  
  -- register begin
  cnt_upcounter_register : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      s_rec <= std_logic_vector'("0000");
    elsif rising_edge(system1000) then
      s_rec <= result;
    end if;
  end process;
  -- register end
  
  s <= s_rec;
end;
