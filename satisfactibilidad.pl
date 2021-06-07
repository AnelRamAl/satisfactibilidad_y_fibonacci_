% Autor:
% Fecha: 01/03/2020

:- op(610, fy, -). % negacion
:- op(620, xfy, &). % conjuncion
:- op(630, xfy, v). % disyuncion
:- op(640, xfy, =>). % condicional
:- op(650, xfy, <=>). % equivalencia

valor_de_verdad(0).
valor_de_verdad(1).

funci�n_de_verdad(v, 0, 0, 0) :- !.
funci�n_de_verdad(v, _, _, 1).
funci�n_de_verdad(&, 1, 1, 1) :- !.
funci�n_de_verdad(&, _, _, 0).
funci�n_de_verdad(=>, 1, 0, 0) :- !.
funci�n_de_verdad(=>, _, _, 1).
funci�n_de_verdad(<=>, X, X, 1) :- !.
funci�n_de_verdad(<=>, _, _, 0).

funci�n_de_verdad(-, 1, 0).
funci�n_de_verdad(-, 0, 1).

valor(F, I, V) :- memberchk((F,V), I).                                          %  valor((p v q) & (-q v r),[(p,1),(q,0),(r,1)],V).
valor(-A, I, V) :- valor(A, I, VA), funci�n_de_verdad(-, VA, V).
valor(F, I, V) :- F =..[Op,A,B], valor(A, I, VA), valor(B, I, VB),
funci�n_de_verdad(Op, VA, VB, V).
                                                                                % interpretaciones_f�rmula((p v q) & (-q v r),L).

interpretaciones_f�rmula(F,U) :- findall(I,interpretaci�n_f�rmula(I,F),U).
                                                                                % interpretaci�n_f�rmula(I,(p v q) & (-q v r)).

interpretaci�n_f�rmula(I,F) :- s�mbolos_f�rmula(F,U),
interpretaci�n_s�mbolos(U,I).
                                                                                %  s�mbolos_f�rmula((p v q) & (-q v r), U).
s�mbolos_f�rmula(F,U) :- s�mbolos_f�rmula_aux(F,U1), sort(U1,U).
s�mbolos_f�rmula_aux(F,[F]) :- atom(F).
s�mbolos_f�rmula_aux(-F,U) :- s�mbolos_f�rmula_aux(F,U).
s�mbolos_f�rmula_aux(F,U) :- F =..[_Op,A,B], s�mbolos_f�rmula_aux(A,UA),
s�mbolos_f�rmula_aux(B,UB), union(UA,UB,U).

interpretaci�n_s�mbolos([],[]).                                                 %  interpretaci�n_s�mbolos([p,q,r],I).
interpretaci�n_s�mbolos([A|L],[(A,V)|IL]) :- valor_de_verdad(V),
interpretaci�n_s�mbolos(L,IL).

es_modelo_f�rmula(I,F) :- valor(F,I,V),                                         % es_modelo_f�rmula([(p,1),(q,0),(r,1)], (p v q) & (-q v r)).
V = 1.                                                                          % es_modelo_f�rmula([(p,0),(q,0),(r,1)], (p v q) & (-q v r)).

                                                                                % modelo_f�rmula(I,(p v q) & (-q v r)).
modelo_f�rmula(I,F) :- interpretaci�n_f�rmula(I,F),
es_modelo_f�rmula(I,F).

modelos_f�rmula(F,L) :- findall(I,modelo_f�rmula(I,F),L).                       % modelos_f�rmula((p v q) & (-q v r),L).

es_satisfacible(F) :- interpretaci�n_f�rmula(I,F),                              % es_satisfacible((p & q) & (x => s) & (y => -t) & (n v u) & (m v -w) & (xf => s)).
es_modelo_f�rmula(I,F).                                                         % es_satisfacible((p v q) & (-q v r)).
                                                                                % es_satisfacible((p & q) & (p => r) & (q => -r)).


% Para calcular tiempo de ejecuci�n :  time(es_satisfacible((p & q) & (x => s) & (y => -t) & (n v u) & (m v -w) & (xf => s))).
