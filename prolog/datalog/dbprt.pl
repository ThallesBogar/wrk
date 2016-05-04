% File: db.pl
:- use_module(library(file_utils)).
:- use_package(persdb).

:- persistent(r/3, dbdir).

persistent_dir(dbdir, '/Users/ufu/wrk/prolog').

prtAll :-
    r(X, Y, Z),
    write(r(X, Y, Z)),
    nl,
    fail.
prtAll.

pTerms([]) :- !.
pTerms([T|Ts]) :-
    assertz_fact(T),
    pTerms(Ts).

main :- 
    prtAll.
    
%    string2term(A, S),
   
