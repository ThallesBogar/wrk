inc x = x + 1
dec x = x - 1

doublex x = x*2

fun x = if x > 3
           then x + 1
        else
           x - 1

myHead [] = error "empty list"
myHead (x:xs) = x

myTail [] = error "empty list"
myTail (x:xs) = xs

myInit [] = error "emprty list"
myInit [_] = []
myInit (x:xs) = x:myInit xs

myLast [] = error "emprty list"
myLast [x] = [x]
myLast (x:xs) = myLast xs

myReplicate n x = if n <= 0
                     then []
                  else
                     x:myReplicate (n-1) x

myTake n _
   | n <= 0 = []
myTake _ [] = []
myTake n (x:xs) = x:myTake (n-1) xs

myRepeat 0 x = []  
myRepeat n x = x:myRepeat (n-1) x

myElem _ [] = False
myElem elt (x:xs)
   | elt == x  = True
   | otherwise = myElem elt xs
