:- use_package(persdb).
:- use_package(library(file_utils)).

persistent_dir(db, './').

:- persistent(pessoa/2, db).

prtAll :-
	pessoa(X,Y),
	write('Chave: '), write(X), nl,
	write('Nome: '), write(Y), nl,
	nl.
prtAll.

main :-
	prtAll.