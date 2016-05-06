module CRC where
import CLaSH.Prelude

crc32T :: Unsigned 32 -> Unsigned 8 -> (Unsigned 32, Unsigned 32)
crc32T prevCRC c = (prevCRC', o)
 where
  prevCRC' = crc32Step prevCRC c
   o = prevCRC
   
   crc32 :: Signal (Unsigned 8) -> Signal (Unsigned 32)
   crc32 = mealy crc32T 0


crc32Step :: Unsigned 32 -> Unsigned 8 -> Unsigned 32
crc32Step prevCRC c =
 flipAll (tblEntry `xor` (crc `shiftR` 8))
  where
   tblEntry = crc32Table (truncateB crc `xor` c)
   crc = flipAll prevCRC
   flipAll = xor 0xffffffff

crc32Table :: Unsigned 8 -> Unsigned 32
crc32Table = unpack . asyncRomFile d256 "crc32_table.bin"

topEntity :: Signal (Unsigned 8) -> Signal (Unsigned 32)
topEntity = crc32

testInput :: Signal (Unsigned 8)
testInput = stimuliGenerator $(v [0 :: Unsigned 8, 79,
112,116,105,118,101,114])
expectedOutput :: Signal (Unsigned 32) -> Signal Bool
expectedOutput = outputVerifier $(v [0 :: Unsigned 32,
3523407757, 2814004990, 3634756580, 584440114, 781824552,
1593772748, 2102791115])