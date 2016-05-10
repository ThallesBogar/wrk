% File: db.pl
:- use_module(library(file_utils)).
:- use_package(persdb).

:- persistent(empregado/3, dbdir).
:- persistent(dep/2, dbdir).

persistent_dir(dbdir, './').

insertTable([]) :- !.
inserTable([dep(Departamento, Chefe)|Ts]) :-
    dep(Departamento, _),!,
    write(dep(Departamento, Chefe)), write(' já inserido!'), nl,
    insertTable(Ts).
insertTable([empregado(Num, Nome, Departamento)|Ts]) :-
    empregado(Num, _, _), !,
    write(empregado(Num, Nome, Departamento)), write(' já inserido!'), nl,
    insertTable(Ts).
insertTable([dep(Departamento, Chefe)|Ts]) :- !,
    assertz_fact(dep(Departamento, Chefe) ),
    insertTable(Ts).
insertTable([empregado(Num, Nome, Departamento)|Ts]) :-
    dep(Departamento,_), !,
    assertz_fact(empregado(Num, Nome, Departamento)),
    insertTable(Ts).


main(Argv) :-
    [A|_] = Argv, 
    file_terms(A, Terms),
    write(Terms), nl,
    insertTable(Terms).
   
