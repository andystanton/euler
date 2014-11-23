let divisibleBy3or5 seq =
   let isDivisibleBy3or5 x = x%3 = 0 || x%5 = 0
   Seq.sum(Seq.filter isDivisibleBy3or5 seq)

let total = divisibleBy3or5(seq { 0 .. 999 })

printfn "%d" total
