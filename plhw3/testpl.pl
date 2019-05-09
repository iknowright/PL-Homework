parent(1, 2).

parent(root, _).

c_reverse([],Z,Z).
c_reverse([H|T],Z,Acc) :- c_reverse(T,Z,[H|Acc]).

append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).  

parents(Temp, Result, root):-
    Result = Temp.
    
parents(I, F,X):-
    % format("Initial list ~w, Current child ~w~n",[I, X]),
    parent(Y1, X),
    % writeln(Y1),
    append(I, [Y1], Fnew),
    % writeln(Fnew),
    NewF = Fnew,
    parents(NewF, F, Y1).

get_lists(A1, A2 ,C1, C2):-
    parents([], T1, C1),
    parents([], T2, C2),
    c_reverse(T1, A1, []),
    c_reverse(T2, A2, []).

lowest_common_ancester([], [], H1, H2):-
    H1 \= H2,
    parent(X, H1),
    writeln(X).

lowest_common_ancester(_, [], H1, _):-
    writeln(H1).

lowest_common_ancester([], _, H1, _):-
    writeln(H1).

lowest_common_ancester(_, _, H1, H2):-
    H1 \= H2,
    parent(X, H1),
    writeln(X).

lowest_common_ancester(A, B, _, _):-
    [H1|T1] = A,
    [H2|T2] = B,
    format("~w ~w ~w ~w~n", [T1, T2, H1, H2]),
    lowest_common_ancester(T1, T2, H1, H2).

main:-
    writeln([]),
    get_lists(A1, A2 ,2, 1),
    format("~w ~w~n", [A1, A2]),
    nl,
    lowest_common_ancester(A1,A2, _, _).

:- initialization(main).

parse_pair(I, A, B),
get_lists(A1, A2 , A, B),
format("~w ~w~n", [A1, A2]),
common_ancester(A1, A2),

parent(root, _).

append([],X,X).
append([X|Y],Z,[X|W]) :- append(Y,Z,W).  

member(X,[X|_], success).
member(_,[], fail).
member(X,[_|T],A) :- member(X,T,A).

common_ancester([root|_], _):-
    writeln("no common ancester").

common_ancester([H|T], L2):-
    member(H, L2, X),
    X = success
    ->
    write("Answer is "),
    writeln(H)
    ;
    common_ancester(T, L2).

parents(Temp, Result, root):-
    Result = Temp.
    
parents(I, F,X):-
    format("Initial list ~w, Current child ~w~n",[I, X]),
    parent(Y1, X),
    % writeln(Y1),
    append(I, [Y1], Fnew),
    % writeln(Fnew),
    NewF = Fnew,
    parents(NewF, F, Y1).

get_lists(A1, A2 ,C1, C2):-
    parents([C1], A1, C1),
    parents([C2], A2, C2).

main:-
    get_lists(A1, A2 , 5, 6),
    format("~w ~w~n", [A1, A2]),
    common_ancester(A1,A2).

:- initialization(main).