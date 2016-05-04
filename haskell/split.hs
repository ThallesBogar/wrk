import System.Environment
import Control.Monad
import Data.List.Split

q = dropBlanks $ dropDelims $ oneOf ";:.,"

main = do
   [f] <- getArgs
   contents <- readFile f
   let words = split q contents
   putStrLn ("File: " ++ f)
   mapM_ putStrLn (words)
