-module(one).
-export([main/0, sum/1, sum/2, mod/2]).

mod(X,Y)->(X rem Y + Y) rem Y.
sum(L) -> sum(L,0).
sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, H+Sum).

main() ->
    io:format("~p\n", [sum(
        lists:filter(
            fun (X) -> (mod(X, 3) == 0) or (mod(X, 5) == 0) end,
            lists:seq(1,999)
        )
    )]).
