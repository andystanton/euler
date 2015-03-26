%% -*- erlang -*-
%%! -smp enable -sname one -mnesia debug verbose

mod(X,Y)->(X rem Y + Y) rem Y.
sum(L) -> sum(L,0).
sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, H+Sum).

main([]) ->
    main().

main() ->
    io:format("~p\n", [sum(
        lists:filter(
            fun (X) -> (mod(X, 3) == 0) or (mod(X, 5) == 0) end,
            lists:seq(1,999)
        )
    )]).