import System.Environment
import Text.Read

fact 0 = 1
fact n = n*fact (n-1)

pfact (Just n) = show n ++ "->" ++ show (fact n)
pfact (Nothing) = "Argument must be an Integer!!"

main = do
   [num] <- getArgs
   let x = readMaybe num :: Maybe Integer
   putStrLn (pfact x)
