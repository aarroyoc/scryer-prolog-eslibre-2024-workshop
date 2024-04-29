:- use_module(library(lists)).

zebra(Sol) :-
    Sol = [
	% casa(Color, Nacionalidad, Profesion, Animal, Bebida),
	casa(C1, N1, P1, A1, B1),
	casa(C2, N2, P2, A2, B2),
	casa(C3, N3, P3, A3, B3),
	casa(C4, N4, P4, A4, B4),
	casa(C5, N5, P5, A5, B5)
    ],
    member(casa(roja, ingles, _, _, _), Sol),
    member(casa(_, español, _, perro, _), Sol),
    member(casa(_, japones, pintor, _, _), Sol),
    member(casa(_, italiano, _, _, te), Sol),
    Sol = [casa(_, noruego, _, _, _)|_],
    member(casa(verde, _, _, _, cafe), Sol),
    append(_, [casa(blanca, _, _, _, _), casa(verde, _, _, _, _)|_], Sol),
    member(casa(_, _, escultor, caracoles, _), Sol),
    member(casa(amarilla, _, diplomatico, _, _), Sol),
    append(X, [casa(_, _, _, _, leche)|Y], Sol),
    length(X, 2),
    length(Y, 2),
    next_to(casa(_, noruego, _, _, _), casa(azul, _, _, _, _), Sol),
    member(casa(_, _, violinista, _, zumo), Sol),
    next_to(casa(_, _, _, zorro, _), casa(_, _, doctor, _, _), Sol),
    next_to(casa(_, _, _, caballo, _), casa(_, _, diplomatico, _, _), Sol).

next_to(X, Y, Sol) :-
    append(_, [X,Y|_], Sol).
next_to(X, Y, Sol) :-
    append(_, [Y,X|_], Sol).
	
