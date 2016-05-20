main(Args) :-
    write('Content-type: text/html'),
    nl, nl,
    write('<html>'),
    nl,
    write('<body>'),
    nl,
    write('<p>'),
    getenvstr('HOME', X),
    convert(X),
    write('</p>'),
    nl,
    write('</body>'),
    nl,
    write('</html>').

convert(X) :-
    atom_codes(Atom, X),
    write(Atom).
    




