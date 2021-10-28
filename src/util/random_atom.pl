:- module('random_atom', [random_atom/2]).

:- dynamic cached_tokens/1.

tokens(Tokens) :- cached_tokens(Tokens), !.
tokens(Tokens) :-
    atom_codes('azertyuiopqsdfghjklmwxcvbnAZERTYUIOPQSDFGHJKLMWXCVBN0123456789', Tokens),
    assertz(cached_tokens(Tokens)).

random_atom(Length, Identifier) :-
    random_codes(Length, Codes-[]),
    atom_codes(Identifier, Codes).
random_atom(Length, Identifier) :- random_atom(Length, Identifier).

random_codes(X, T-T) :- X =< 0, !.
random_codes(Length, [Element|Elements]-T) :-
    Length > 0,
    Nlength is Length - 1,
    tokens(Tokens),
    random_member(Element, Tokens),
    random_codes(Nlength, Elements-T).