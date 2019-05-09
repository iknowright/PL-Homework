:- dynamic parent/2.
parent(root,_).

append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).  

member(X,[X|_], success).
member(_,[], fail).
member(X,[_|T],A) :- member(X,T,A).

common_ancester([root|_], _).
common_ancester([H|T], L2):-
    member(H, L2, X),
    X = success
    ->
    writeln(H)
    ;
    common_ancester(T, L2).

parents(Temp, Result, root):-
    Result = Temp.
    
parents(I, F,X):-
    parent(Y1, X),
    append(I, [Y1], Fnew),
    NewF = Fnew,
    parents(NewF, F, Y1).

get_lists(A1, A2 ,C1, C2):-
    parents([C1], A1, C1),
    parents([C2], A2, C2).

% --------------------------------------------------

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
    asserta(parent(A, B)),
    M is X - 1,
    loop_tree(M).

output([]).
output([H|T]):-
    parse_pair(H, A, B),
    get_lists(A1, A2 , A, B),
    common_ancester(A1, A2),
    output(T).

program:-
    readln(In),
    [I|_] = In,
    Input is I - 1,
    loop_tree(Input),
    readln(Qin),
    [Qinput|_] = Qin,
    loop_query(Qinput,[],Pairs),
    output(Pairs).

main:-
    program,
    halt.

:- initialization(main).