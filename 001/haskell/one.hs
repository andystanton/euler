getnums xs = [ if x `mod` 3 == 0 || x `mod` 5 == 0 then x else 0 | x <- xs ]
main = print (sum (getnums [1,2..999]))
