import System.Posix.Env
import System.Environment
import Text.Read

getName (Just y) = y
getName Nothing = "Camarada"

main = do
   putStrLn "Content-type: text/plain\n"
   [x] <- getArgs
   let y = readMaybe x :: Maybe Char
   putStr "Hello, "
   putStrLn (getName y)
