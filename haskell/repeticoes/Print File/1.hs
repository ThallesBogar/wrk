import System.Environment

main = do
   [f] <- getArgs
   s <- readFile f
   putStrLn s
