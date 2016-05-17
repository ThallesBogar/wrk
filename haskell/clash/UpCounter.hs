module UpCounter where
import CLaSH.Prelude

upCounter :: Signal Bool -> Signal (Unsigned 8)
upCounter clk = s
       where
          s = regEn 0 enable (s + 1)

clock = register False (not1 clock)

topEntity = upCounter