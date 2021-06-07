% Autor:
% Fecha: 01/03/2020

:- op(610, fy, -). % negacion
:- op(620, xfy, &). % conjuncion
:- op(630, xfy, v). % disyuncion
:- op(640, xfy, =>). % condicional
:- op(650, xfy, <=>). % equivalencia

valor_de_verdad(0).
valor_de_verdad(1).

función_de_verdad(v, 0, 0, 0) :- !.
función_de_verdad(v, _, _, 1).
función_de_verdad(&, 1, 1, 1) :- !.
función_de_verdad(&, _, _, 0).
función_de_verdad(=>, 1, 0, 0) :- !.
función_de_verdad(=>, _, _, 1).
función_de_verdad(<=>, X, X, 1) :- !.
función_de_verdad(<=>, _, _, 0).

función_de_verdad(-, 1, 0).
función_de_verdad(-, 0, 1).

valor(F, I, V) :- memberchk((F,V), I).                                          %  valor((p v q) & (-q v r),[(p,1),(q,0),(r,1)],V).
valor(-A, I, V) :- valor(A, I, VA), función_de_verdad(-, VA, V).
valor(F, I, V) :- F =..[Op,A,B], valor(A, I, VA), valor(B, I, VB),
función_de_verdad(Op, VA, VB, V).
                                                                                % interpretaciones_fórmula((p v q) & (-q v r),L).

interpretaciones_fórmula(F,U) :- findall(I,interpretación_fórmula(I,F),U).
                                                                                % interpretación_fórmula(I,(p v q) & (-q v r)).

interpretación_fórmula(I,F) :- símbolos_fórmula(F,U),
interpretación_símbolos(U,I).
                                                                                %  símbolos_fórmula((p v q) & (-q v r), U).
símbolos_fórmula(F,U) :- símbolos_fórmula_aux(F,U1), sort(U1,U).
símbolos_fórmula_aux(F,[F]) :- atom(F).
símbolos_fórmula_aux(-F,U) :- símbolos_fórmula_aux(F,U).
símbolos_fórmula_aux(F,U) :- F =..[_Op,A,B], símbolos_fórmula_aux(A,UA),
símbolos_fórmula_aux(B,UB), union(UA,UB,U).

interpretación_símbolos([],[]).                                                 %  interpretación_símbolos([p,q,r],I).
interpretación_símbolos([A|L],[(A,V)|IL]) :- valor_de_verdad(V),
interpretación_símbolos(L,IL).

es_modelo_fórmula(I,F) :- valor(F,I,V),                                         % es_modelo_fórmula([(p,1),(q,0),(r,1)], (p v q) & (-q v r)).
V = 1.                                                                          % es_modelo_fórmula([(p,0),(q,0),(r,1)], (p v q) & (-q v r)).

                                                                                % modelo_fórmula(I,(p v q) & (-q v r)).
modelo_fórmula(I,F) :- interpretación_fórmula(I,F),
es_modelo_fórmula(I,F).

modelos_fórmula(F,L) :- findall(I,modelo_fórmula(I,F),L).                       % modelos_fórmula((p v q) & (-q v r),L).

es_satisfacible(F) :- interpretación_fórmula(I,F),                              % es_satisfacible((p & q) & (x => s) & (y => -t) & (n v u) & (m v -w) & (xf => s)).
es_modelo_fórmula(I,F).                                                         % es_satisfacible((p v q) & (-q v r)).
                                                                                % es_satisfacible((p & q) & (p => r) & (q => -r)).


% Para calcular tiempo de ejecución :  time(es_satisfacible((p & q) & (x => s) & (y => -t) & (n v u) & (m v -w) & (xf => s))).
