module CNT where
import CLaSH.Prelude

upCounter :: Signal Bool -> Signal (BitVector 4)
upCounter clk = s
   where
     s = register 0 (mux clk (s+1) s)
  
clock = register False (not1 clock)

topEntity :: Signal Bool -> Signal (BitVector 4)
topEntity = upCounter