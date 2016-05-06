module CODE where
import CLaSH.Prelude

decoderShift :: Bool -> BitVector 4 -> BitVector 16
decoderShift enable binaryIn = shiftL 1 (fromIntegral binaryIn)
