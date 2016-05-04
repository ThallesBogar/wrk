function aux = do
         putStrLn aux
         getLine

function2 var1 var2 = do
       line1 <- function var1
       line2 <- function var2
       return (line1 ++ " and " ++ line2)

main = do
    line <- function "Enter a Value: "
    putStrLn (line)

