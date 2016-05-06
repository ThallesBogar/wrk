module Mealy where

import CLaSH.Prelude

ma s (x,y) = s + x*y

macT s (x,y) = (s',output)
  where
      s' = ma s (x,y)
      output = s

mac = mealy macT 0

topEntity :: Signal (Signed 9, Signed 9) -> Signal (Signed 9)
topEntity = mac