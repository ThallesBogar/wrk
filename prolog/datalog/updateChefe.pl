%%File: attDb.pl
%%Atualiza a base de dados
:- use_module(library(file_utils)).
:- use_package(persdb).


%%:- persistent(empregado/3, dbdir).
:- persistent(dep/2, dbdir).

persistent_dir(dbdir, '/Users/ufu/wrk/prolog').

updateChefe([]) :- !, write('Fim'), nl.
%%Verficando se já existe o fato a ser atualizado.
updateChefe([dep(Departamento, NovoChefe)|Ts]) :-
	dep(Departamento, NovoChefe), !,
	write(NovoChefe), write(' já cadastrado em '),
	write(Departamento), nl,
	updateChefe(Ts).
%%Se não existe, faz a atualização
updateChefe([Departamento, NovoChefe|_]) :- !,
	dep(Departamento, Chefe),
	retract_fact(dep(Departamento, NovoChefe)),
	write('Atualizado: '), write(Chefe),
	write(' -> '), write(NovoChefe).

main(Argv) :-
	[A|_] = Argv,
	file_terms(A, Terms),
	write(Terms), nl,
	updateChefe(Terms),
	write('Chegou aqui'), nl.