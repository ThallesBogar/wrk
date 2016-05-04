:- use_package(iso).
:- use_package(persdb).
:- use_module(library(file_utils)).

persistent_dir(db, './').

:- persistent(rel/2, db).
%% Um fato por vez.
insertTabel([]) :- !.
insertTable([rel(X,_)|Ts]) :-
	rel(X,_), !,
	write('Já existe.'), nl,
	insertTable(Ts).
insertTable([rel(X,Y)|Ts]) :- !,
	assertz_fact(rel(X,Y)),
	insertTable(Ts).

main(Argv) :-
	[A|_] = Argv,
	file_terms(A, Terms),
	write(Terms), nl,
	insertTable(Terms).