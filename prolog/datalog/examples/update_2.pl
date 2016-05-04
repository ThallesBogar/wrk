:- use_module(library(file_utils)).
:- use_package(iso).
:- use_package(persdb).

persistent_dir(db, './').
:- persistent(rel/2, db).

eraseOne(X) :-
	retract_fact(rel(X,_)).

updateCharByKey([]) :- !,
	write('Fim'), nl.
updateCharByKey([rel(Chave, Novo)|Ts]) :-
	rel(Chave, _),
	eraseOne(Chave),
	assertz_fact(rel(Chave, Novo)),
	write('Atualizado'), nl,
	updateCharByKey(Ts).

main(Argv) :-
	[A|_] = Argv,
	file_terms(A, Terms),
	write(Terms), nl,
	updateCharByKey(Terms),
	findall(Y,rel(_,Y),L),
	write(L).