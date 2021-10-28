:- module('main_controller', []).

:- use_module(library(http/html_write)).

:- use_module('../templates/layout/body/body').
:- use_module('../templates/layout/head/head').

index(_Request) :-
    reply_html_page([\head], [\body_('')]).