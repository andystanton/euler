-module(one).
-export([main/0, sum/1, sum/2, mod/2, addIfDivisibleBy3or5/2]).

main() ->
    io:format("~p\n", [sum(lists:seq(1,999))]).

sum(L) -> sum(L,0).
sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, addIfDivisibleBy3or5(Sum, H)).

mod(X,Y)->(X rem Y + Y) rem Y.

addIfDivisibleBy3or5(Sum, H) ->
    case (mod(H, 3) == 0) or (mod(H, 5) == 0) of
        true -> H+Sum;
        _Else -> Sum
    end.
