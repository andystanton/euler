let range a b =
    let rec aux a b =
      if a > b then [] else a :: aux (a+1) b  in
    if a > b then List.rev (aux b a) else aux a b;;

let rec sum list = match list with
    | [] -> 0
    | h :: t -> h + sum t

let filtered = List.filter (fun x -> x mod 3 = 0 || x mod 5 = 0) (range 1 999);;

print_int (sum filtered);;
