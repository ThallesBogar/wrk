:- use_package(iso).
:- use_package(persdb).

persistent_dir(db, './').

:- persistent(bar/1, db).

main :-
	read(X),
	assertz_fact(bar(X)),
	findall(Y, bar(Y), L),
	write(L).

erase_one :-
	retract_fact(bar(_)).
erase_all :-
	retract_fact(bar(_)).