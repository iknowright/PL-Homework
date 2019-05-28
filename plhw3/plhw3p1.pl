:- dynamic conjecture/2.

loop_divisor(_, _, 0, not_prime).
loop_divisor(1, _, _, prime).

loop_divisor(N,Number, _, Y):-
    N > 0,
    X is mod(Number, N),
    M is N - 1,
    loop_divisor(M,Number, X, Y).

is_prime(Number, P):-
    N is truncate(sqrt(Number)),
    loop_divisor(N,Number, 100, Y),
    P = Y.

pair(_, prime, _, not_prime).
pair(_, not_prime, _, prime).
pair(_, not_prime, _, not_prime).

pair(X, prime, Y, prime):-
    format("~w ~w ~n", [X, Y]).

conjecture(L, R):-
    is_prime(L, X),
    is_prime(R, Y),
    pair(L, X, R, Y),
    L1 is L + 1,
    R1 is R - 1,
    conjecture(L1,R1).

last_conjecture(_, not_prime).

last_conjecture(Y, prime):-
    format("~w ~w ~n", [Y, Y]).

program:- program_loop.

program_loop:-
    write("Input : "),    
    readln(X),
    [Number|_] = X,
    Y is div(Number,2),
    asserta(conjecture(Y, Y)),
    End is Number - 2,
    write("Output : "),
    conjecture(2, End),
    is_prime(Y, P),
    P1 = P,
    last_conjecture(Y, P1).

main:-
    program,
    halt.

:- initialization(main).