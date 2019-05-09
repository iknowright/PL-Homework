relative(1, 4).
relative(1, 2).
relative(1, 6).
relative(2, 3).
relative(2, 1).
relative(3, 2).
relative(3, 4).
relative(3, 5).
relative(4, 1).
relative(4, 3).
relative(4, 5).
relative(5, 4).
relative(5, 3).
relative(5, 6).
relative(6, 5).
relative(6, 1).

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

main:-
    findall(X,relative(1,X),Z),
    writeln(Z),
    union(Z, [], U),
    writeln(U),
    do_union_self([1],[1],[1], Final),
    writeln(Final),    
    halt.
    
:- initialization main.