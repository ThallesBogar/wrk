%:- use_package(iso).
:- use_package(persdb).
:- use_module(library(file_utils)).

persistent_dir(db, './').

:- persistent(pessoa/2, db).

%% Um fato por vez.
insertTable([]) :- !.
insertTable([pessoa(X,_)|Ts]) :-
	pessoa(X,_), !,
	write('Já existe.'), nl,
	insertTable(Ts).
insertTable([pessoa(X,Y)|Ts]) :- !,
	assertz_fact(pessoa(X,Y)),
	insertTable(Ts).

main(Argv) :-
	[A|_] = Argv,
	write('start'), nl,
	file_terms(A, Terms),
	write(Terms), nl,
	insertTable(Terms),
	write(Terms), nl.