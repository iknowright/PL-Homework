loop_divisor(_, _, 0, not_prime).
loop_divisor(1, _, _, prime).


loop_divisor(N,Number, _, Y):-
    N > 0,
    X is mod(Number, N),
    M is N - 1,
    loop_divisor(M,Number, X, Y).
    % format("~w ~w ~w ~w ~n", [N, Number, X, Y]).

is_prime(Number, P):-
    N is truncate(sqrt(Number)),
    loop_divisor(N,Number, 100, Y),
    P = Y.

conjecture(L, prime, R, prime):-
    format("Output ~w ~w ~n", [L,R]).

conjecture(L, _, R, _):-
    L1 is L - 1,
    R1 is R + 1,
    is_prime(L1, X),
    is_prime(R1, Y),
    conjecture(L1, X, R1, Y).

program:- program_loop.

program_loop:-
    write("Input : "),    
    readln(X),
    [Number|_] = X,
    Y is div(Number,2),
    conjecture(Y, not_prime, Y, not_prime),
    program_loop.

main:-
    program,
    halt.

:- initialization(main).