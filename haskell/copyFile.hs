import System.Environment

ler arquivo = do
[f,g] <- getArgs
s <- readFile f
writeFile g s
