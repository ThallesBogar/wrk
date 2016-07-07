import System.Environment
import Text.Read

fib n f1 f2
  | n < 2 = f1
  | otherwise = fib (n-1) (f1+f2) f1

pfib (Just n) = show n ++ "->" ++ show (fib n 1 1)
pfib Nothing = "Argument must be an integer"

main = do
   [num] <- getArgs
   let x = readMaybe num :: Maybe Integer
   putStrLn (pfib x)
