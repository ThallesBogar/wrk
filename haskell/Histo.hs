module Histo where
import Data.Char

asciiFilter xs = filter accept xs where
     accept x = x >= 'a' && x <= 'z'

histo s = [(length.filter (==x)) s | x <- ['a' .. 'z']]

histogram inFile = do
   xs <- readFile inFile
   let txt = asciiFilter [toLower x | x <- xs]
   let hg = histo txt
   putStrLn (show hg)
