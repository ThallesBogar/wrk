hurt(run_over(H), H) :- animal(H).
animal(H) :- human(H).
object(Thing) :- animal(Thing).

human(X) :- man(X).
human(X) :- woman(X).

forbiden(R, B) :-
    robot(R),
    can_do(R, B),
    hurt(B, H),
    human(H).

must_do(R, Action) :-
    robot(R),
    can_do(R, Action),
    dangerous(C, H),
    human(H),
    remove(Action, H, C).

must_do(R, Action) :-
    robot(R),
    can_do(R, Action),
    requested(H, R, Action),
    human(H),
\+ forbiden(R, Action).

can_do(R, forward(S)) :-
    robot(R), car(R),
    road(S), straight(S).

can_do(R, run_over(A)) :-
    animal(A),
    robot(R),
    car(R).

robot(moonrover).
robot(google_car).
car(google_car).

man(id(sebastian, thrun)).


