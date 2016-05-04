:- use_package(iso).
:- use_package(persdb).

persistent_dir(db, './').

:- persistent(bar/1, db).

eraseOne :-
	retract_fact(bar(_)).

main:-
	eraseOne.