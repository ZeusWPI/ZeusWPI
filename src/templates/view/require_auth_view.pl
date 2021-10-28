:- module(require_auth_view, [no_auth_view/1]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

no_auth_view(Content) :-
    page_(
        p(Content)
    ).