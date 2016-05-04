:- use_package(iso).
:- use_package(persdb).

persistent_dir(db, './').

:- persistent(bar/1, db).

updateOne(X, X_novo) :-
	bar(X),
	retract_fact(bar(X)),
	assertz_fact(bar(X_novo)).

main:-
	read(X),
	read(Y),
	updateOne(X,Y).