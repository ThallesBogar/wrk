%%Criando variavel que será utilizada para guardar o último caminho percorrido. Esta variável possui dois campos, um para armazanar o caminho e outro a distancia daquele caminho.
:-dynamic
      caminho_ant/2.

%%Definindo o grafo:
aresta(a,b,85).
aresta(a,c,217).
aresta(a,e,173).
aresta(b,f,80).
aresta(f,i,250).
aresta(i,j,84).
aresta(j,h,167).
aresta(j,e,502).
aresta(h,d,183).
aresta(h,c,103).
aresta(c,g,186).

%%Definição de caminho, aqui é onde está definido que o grafo é não direcional:
caminho(De, Para, Dist) :- aresta(De, Para, Dist).
caminho(De, Para, Dist) :- aresta(Para, De, Dist).

%%Função que verifica se determinado nó ou vértice já está no caminho:
checar_caminho(Para, [Para|_]) :- !.
checar_caminho(Para, [_|Resto]) :- checar_caminho(Para, Resto).

%%Função que acha o caminho mais curto:
mais_curto([C|Caminho], Dist) :-
    caminho_ant([C|_], D), !, Dist < D,
    retract(caminho_ant([C|_], _)),
    assert(caminho_ant([C|Caminho], Dist)).

mais_curto(Caminho, Dist) :-
    assert(caminho_ant(Caminho, Dist)).

	
%%Função que vai caminhar pelo grafo:
caminhar(De, Caminho, Dist) :-
    caminho(De, Para, D),
    \+ checar_caminho(Para, Caminho),
    mais_curto([Para,De|Caminho], Dist+D),
    caminhar(Para, [De|Caminho], Dist+D).

caminhar(De) :-
    retractall(caminho_ant(_,_)),
    caminhar(De, [], 0).

caminhar(_).

%%Funções para inverter a pilha:
inverter2([], R, R) :- !.
inverter2([X|Xs], Rs, R) :- inverter2(Xs, [X|Rs], R). 

inverter(X, Y) :- inverter2(X, [], Y). 


dijkstra(De, Para) :-
    caminhar(De),
    caminho_ant([Para|CaminhoInv], Dist),
    inverter([Para|CaminhoInv], Caminho),
    Distancia is Dist, !,
    write('O caminho mais curto é: '),
    write(Caminho),
    write(' cuja distância é: '),
    write(Distancia).

dijkstra(De, Para) :-
    write(' Não existe rota de '),
    write(De),
    write(' para '),
    write(Para).
