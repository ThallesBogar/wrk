:- use_module(library(file_utils)).
:- use_package(iso).
:- use_package(persdb).

persistent_dir(db, './').
:- persistent(pessoa/2, db).


atualizar([]) :- !,
	write('Fim'), nl.
atualizar([pessoa(Chave, Novo)|Ts]) :-
	pessoa(Chave, _),
	retract_fact(pessoa(Chave,_)),
	assertz_fact(pessoa(Chave, Novo)),
	write('Atualizado'), nl,
	atualizar(Ts).

main(Argv) :-
	[A|_] = Argv,
	file_terms(A, Terms),
	write(Terms), nl,
	atualizar(Terms).