%% File: db.pl
:- use_module(library(file_utils)).
:- use_package(persdb).

:- persistent(r/3, dbdir).

persistent_dir(dbdir, '/Users/ufu/wrk/prolog').

pTerms([]) :- !.
pTerms([r(Id, X, Y)|Ts]) :-
    call(r(Id, _, _) ), !,
    write(r(Id, X, Y)), write(' já inserido!'), nl,
    pTerms(Ts).
pTerms([T|Ts]) :-
    assertz_fact(T),
    pTerms(Ts).

main(Argv) :-
    [A|_] = Argv, 
    file_terms(A, Terms),
    write(Terms), nl,
    pTerms(Terms).
    
%    string2term(A, S),
   
