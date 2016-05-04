module Contador where
import CLaSH.Prelude

upDownCounter clk = s
       where
          s = regEn 0 (clk (s + 1) (s + 1))

clock = register False (not1 clock)

topEntity = upDownCounter