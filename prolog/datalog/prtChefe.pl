% File: db.pl
:- use_module(library(file_utils)).
:- use_package(persdb).

:- persistent(empregado/3, dbdir).
:- persistent(dep/2, dbdir).

persistent_dir(dbdir, './').

prtAll :-
    empregado(Num, Nome, Departamento),
    dep(Departamento, Chefe),
    write('Empregado: '), write(Nome), nl,
    write('Numero: '), write(Num), nl,
    write('Chefe: '), write(Chefe), nl,
    write('Departamento: '), write(Departamento), nl,
    nl,
    fail.
prtAll.

main :- 
    prtAll.
    
%    string2term(A, S),
   
