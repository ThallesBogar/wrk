:- use_package(iso).
:- use_package(persdb).
:- use_module(library(file_utils)).

persistent_dir(db, './').

:- persistent(pessoa/2, db).

prtAll :-
	pessoa(X,Y),
	write('Chave: '), write(X), nl,
	write('Nome: '), write(Y), nl,
	nl,
	fail.
prtAll.

main :-
	prtAll.