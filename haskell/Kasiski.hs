module Kasiski where
import Data.Char

histo s = [(length.filter (==x)) s | x <- ['a' .. 'z']]
histoColumn s j kSz = histo $ col 0 j s [] where
    col i j [] xs = reverse xs
    col i j (x:s) xs | i-j == 0 = col (i+1) (j+kSz) s (x:xs)
    col i j (x:s) xs = col (i+1) j s xs

khi kSz col s = foldl mx 0 [1..9] where
    c = histoColumn s col kSz
    xxs i = sum [c!!j*eH!!(wrap (j-i)) | j <- [0..25]]
    wrap x | x < 0 = 25+x
    wrap x | x > 25 = x-25
    wrap x = x
    mx i j = if xxs i > xxs j then i else j

hack kSz s = [khi kSz coluna s | coluna <- [0..kSz-1]]
 

eH = [102,14,31,58,165,27,28,80,68,0,3,42,
      13,77,93,15,1,79,44,126,21,24,28,0,10,0]

texto = "hrytvgquicqhuhzgqdgdvudkqrytievkitvftryikxhrvvkspwlkvgqqxkqipw\
         \ephbpdxkrrerrehmxhhkqpkeitwdcqhfhhkfevhhvrxjhttrtqvmvlspwlcwen\
         \oqgqethgthevhhgtyco"
