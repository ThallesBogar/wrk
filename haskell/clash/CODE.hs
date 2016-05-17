module CODE where
import CLaSH.Prelude

decoderShift :: Bool -> BitVector 4 -> BitVector 16
decoderShift enable toBinary =
  if enable
    then shiftL 1(fromIntegral toBinary)
  else 0
