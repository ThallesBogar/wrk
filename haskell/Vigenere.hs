module Vigenere where
import Data.Char

wrap x
  | x < 0 = 25 + x
  | x > 25 = x - 25
  |otherwise = x

pos x = (ord (toLower x)) - (ord 'a')
letra i = chr ((ord 'a') + i)

vg p k
  | isAlpha p = letra (wrap ((pos p) + k))
  |otherwise = p

vig s k = codigo where
    repeatKey ks = ks ++ (repeatKey ks)
    key = repeatKey k
    codigo = zipWith vg s key

texto = "hrytvgquicqhuhzgqdgdvudkqrytievkitvftryikxhrvvkspwlkvgqqxkqipw\
         \ephbpdxkrrerrehmxhhkqpkeitwdcqhfhhkfevhhvrxjhttrtqvmvlspwlcwen\
         \oqgqethgthevhhgtyco"
