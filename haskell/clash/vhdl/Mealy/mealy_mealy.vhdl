-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.mealy_types.all;

entity mealy_mealy is
  port(w2              : in mealy_types.tup2;
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out signed(8 downto 0));
end;

architecture structural of mealy_mealy is
  signal y             : signed(8 downto 0);
  signal result_0      : mealy_types.tup2;
  signal tup_case_alt  : mealy_types.tup2;
  signal tup_app_arg   : signed(8 downto 0);
  signal x             : signed(8 downto 0);
  signal tup_app_arg_0 : signed(8 downto 0);
  signal x_app_arg     : signed(8 downto 0);
  signal ww            : signed(8 downto 0);
  signal ww1           : signed(8 downto 0);
  signal x_0           : signed(8 downto 0);
begin
  result <= y;
  
  y <= result_0.tup2_sel1;
  
  result_0 <= tup_case_alt;
  
  tup_case_alt <= (tup2_sel0 => tup_app_arg
                  ,tup2_sel1 => x);
  
  tup_app_arg <= x + tup_app_arg_0;
  
  -- register begin
  mealy_mealy_register : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      x <= to_signed(0,9);
    elsif rising_edge(system1000) then
      x <= x_app_arg;
    end if;
  end process;
  -- register end
  
  tup_app_arg_0 <= resize(ww * ww1, 9);
  
  x_app_arg <= x_0;
  
  ww <= w2.tup2_sel0;
  
  ww1 <= w2.tup2_sel1;
  
  x_0 <= result_0.tup2_sel0;
end;
