:- module('body', [body_//1]).

:- use_module(library(http/html_write)).

:- use_module('alert').
:- use_module('footer').
:- use_module('nav').

:- html_meta body_(html,?,?).

body_(Content) -->
    html([
        \nav,
        div([class='uk-padding'], [
            div([class='uk-container uk-container-large'], [
                \alert,
                Content,
                \footer
            ])
        ])
    ]).