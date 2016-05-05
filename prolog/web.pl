:- use_module('/usr/lib/ciao/ciao-1.14/library/pillow/pillow.pl').

main(_) :-
    get_form_input(Input),
    get_form_value(Input,person_name,Name),
    write('Content-type: text/html'), nl, nl,
    write('<HTML><TITLE>Telephone database</TITLE>'), nl,
    write('<IMG SRC="phone.gif">'),
    write('<H2>Telephone database</H2><HR>'),
    write_info(Name),
    write('</HTML>').
