import System.Environment

conv [] = "<p/>"
conv ('#':title) = "<h1>" ++ title ++ "</h1>"
conv x = x

xml hs = "<html><body>\n" ++ (unlines hs) ++ "\n</body></html>\n"

main = do
   [inFile, outFile] <- getArgs
   s <- readFile inFile
   let xs = lines s
   let html = [conv x | x <- xs]
   writeFile outFile (xml html)
