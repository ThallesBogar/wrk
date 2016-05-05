module Mealy where
import CLaSH.Prelude

mac s (x,y) = (s', s')
    where
      s' = s + x*y

topEntity = mealy mac 0