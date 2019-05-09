:- dynamic relative/2.
rev_relative(A,B):-
    asserta(relative(B,A)).

% -----------------------

union([],[],[]).
union(List1,[],List1).
union(List1, [Head2|Tail2], [Head2|Output]):-
    \+(member(Head2,List1)), union(List1,Tail2,Output).
union(List1, [Head2|Tail2], Output):-
    member(Head2,List1), union(List1,Tail2,Output). 

do_union_self(Ini, [], Temp, Final):-
    length(Ini, X),
    length(Temp, Y),
    X \= Y
    ->
    do_union_self(Ini, Ini, Ini, Final)
    ;
    Final = Ini.

do_union_self(Ini, [Ele|T], Temp, Final):-
    findall(X,relative(Ele,X), AllRelative),
    union(Ini, AllRelative, UnionList),
    do_union_self(UnionList, T, Temp, Final).

check_connected(A,ListB):-
    member(A,ListB),
    writeln("Yes").

check_connected(A,ListB):-
    \+member(A,ListB),
    writeln("No").

% -----------------------

parse_pair(P, A, B):-
    [A|T] = P,
    [B|_] = T.

loop_query(0, Temp, Pairs):-
    Pairs = Temp.
loop_query(X, Temp, Pairs):-
    readln(I),
    append(Temp, [I], NewTemp),
    M is X - 1,
    loop_query(M, NewTemp, Pairs).

ancester(X, A, B):-
    parent(X, A),
    parent(X, B).

loop_tree(0).
loop_tree(X):-
    readln(I),
    parse_pair(I, A, B),
    asserta(relative(A, B)),
    rev_relative(A,B),
    M is X - 1,
    loop_tree(M).

output([]).
output([H|T]):-
    [A|T2] = H,
    [B|_] = T2,
    do_union_self([B],[B],[B], ListB),
    check_connected(A,ListB),
    output(T).

program:-
    readln(In),
    [_|T] = In,
    [Input|_] = T,
    loop_tree(Input),
    readln(Qin),
    [Qinput|_] = Qin,
    loop_query(Qinput,[],Pairs),
    output(Pairs).

main:-
    program,
    halt.

:- initialization(main).
