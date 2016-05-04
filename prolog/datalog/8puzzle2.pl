% Autor: Marcelo Rodrigues de Sousa
% Data: 05/11/2015

busca_profundidade(EstadoInicial,Resp) :-
    busca_profundidade(EstadoInicial,[EstadoInicial],Resp).

busca_profundidade(N,_,[N]) :-
    objetivo(N).
busca_profundidade(N,Visitados,[N|Sol1]) :-
    move(N,N1),
    \+member(N1, Visitados),
    busca_profundidade(N1,[N1|Visitados],Sol1).

%% move o espaço para cima da linha do meio
move([X1,X2,X3, 0,X5,X6, X7,X8,X9],
     [0,X2,X3, X1,X5,X6, X7,X8,X9]).
move([X1,X2,X3, X4,0,X6, X7,X8,X9],
     [X1,0,X3, X4,X2,X6, X7,X8,X9]).
move([X1,X2,X3, X4,X5,0, X7,X8,X9],
     [X1,X2,0, X4,X5,X3, X7,X8,X9]).

%% move o espaço para cima da linha de baixo
move([X1,X2,X3, X4,X5,X6, X7,0,X9],
     [X1,X2,X3, X4,0,X6, X7,X5,X9]).
move([X1,X2,X3, X4,X5,X6, X7,X8,0],
     [X1,X2,X3, X4,X5,0, X7,X8,X6]).
move([X1,X2,X3, X4,X5,X6, 0,X8,X9],
     [X1,X2,X3, 0,X5,X6, X4,X8,X9]).

%% move o espaço para cima da linha do topo
move([0,X2,X3, X4,X5,X6, X7,X8,X9],
     [X4,X2,X3, 0,X5,X6, X7,X8,X9]).
move([X1,0,X3, X4,X5,X6, X7,X8,X9],
     [X1,X5,X3, X4,0,X6, X7,X8,X9]).
move([X1,X2,0, X4,X5,X6, X7,X8,X9],
     [X1,X2,X6, X4,X5,0, X7,X8,X9]).


%% move o espaço para esquerda na linha do topo
move([X1,0,X3, X4,X5,X6, X7,X8,X9],
     [0,X1,X3, X4,X5,X6, X7,X8,X9]).
move([X1,X2,0, X4,X5,X6, X7,X8,X9],
     [X1,0,X2, X4,X5,X6, X7,X8,X9]).

%% move o espaço para esquerda na linha do meio
move([X1,X2,X3, X4,0,X6,X7,X8,X9],
     [X1,X2,X3, 0,X4,X6,X7,X8,X9]).
move([X1,X2,X3, X4,X5,0,X7,X8,X9],
     [X1,X2,X3, X4,0,X5,X7,X8,X9]).

%% move o espaço para esquerda na linha de baixo
move([X1,X2,X3, X4,X5,X6, X7,0,X9],
     [X1,X2,X3, X4,X5,X6, 0,X7,X9]).
move([X1,X2,X3, X4,X5,X6, X7,X8,0],
     [X1,X2,X3, X4,X5,X6, X7,0,X8]).

%% move o espaço para direita na linha do topo
move([0,X2,X3, X4,X5,X6, X7,X8,X9],
     [X2,0,X3, X4,X5,X6, X7,X8,X9]).
move([X1,0,X3, X4,X5,X6, X7,X8,X9],
     [X1,X3,0, X4,X5,X6, X7,X8,X9]).

%% move o espaço para direita na linha do meio
move([X1,X2,X3, 0,X5,X6, X7,X8,X9],
     [X1,X2,X3, X5,0,X6, X7,X8,X9]).
move([X1,X2,X3, X4,0,X6, X7,X8,X9],
     [X1,X2,X3, X4,X6,0, X7,X8,X9]).

%% move o espaço para direita na linha de baixo
move([X1,X2,X3, X4,X5,X6,0,X8,X9],
     [X1,X2,X3, X4,X5,X6,X8,0,X9]).
move([X1,X2,X3, X4,X5,X6,X7,0,X9],
     [X1,X2,X3, X4,X5,X6,X7,X9,0]).

%% move o espaço para baixo da linha do meio
move([X1,X2,X3, 0,X5,X6, X7,X8,X9],
     [X1,X2,X3, X7,X5,X6, 0,X8,X9]).
move([X1,X2,X3, X4,0,X6, X7,X8,X9],
     [X1,X2,X3, X4,X8,X6, X7,0,X9]).
move([X1,X2,X3, X4,X5,0, X7,X8,X9],
     [X1,X2,X3, X4,X5,X9, X7,X8,0]).


objetivo([1,2,3,
          4,0,5,
          6,7,8]).
          
mostra_8_puzzle([]) :- !.
mostra_8_puzzle([H|T]) :-
    mostra_aux(H),
    mostra_8_puzzle(T),!.

mostra_aux([A,B,C,D,E,F,G,H,I]) :-
    write(A - B - C),nl,
    write(D - E - F),nl,
    write(G - H - I),nl,nl,!.


/* largura */
resolve_largura(Inicio, Solucao) :-
    busca_largura([[Inicio]], Solucao).
busca_largura([[N|Caminho]|_], [N|Caminho]):-
    objetivo(N).
busca_largura([[N|Caminho]|Caminhos], Solucao) :-
    bagof([M,N|Caminho],
          ( move(N,M),
            \+(member(M,[N|Caminho])),
            \+(memberEsp(M,Caminhos)) ),
          NovosCaminhos),
    %write([[N|Caminho]|Caminhos]),nl,nl,
    conc(Caminhos, NovosCaminhos, Caminhos1), !,
    busca_largura(Caminhos1, Solucao);
    busca_largura(Caminhos, Solucao).


memberEsp(M,[H|T]) :-
   member(M,H);
   memberEsp(M,T).

conc([],L,L).
conc([H|T],L,[H|R]) :- conc(T,L,R).

%resolve_largura([1,2,3, 4,5,6, 7,8,0],X),mostra_8_puzzle(X),length(X,Comp).
%X = [[1, 2, 3, 4, 0, 5, 6, 7|...], [1, 2, 3, 4, 5, 0, 6|...],
%Comp = 15
%busca_profundidade([1,2,3, 4,5, 6,7,8,0],X),mostra_8_puzzle(X),length(X,Comp).
%X = [[1, 2, 3, 4, 5, 6, 7, 8|...], [1, 2, 3, 4, 5, 0, 7|...],
%Comp = 54251


