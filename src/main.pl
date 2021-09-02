:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_session)).

:- use_module('handlers').

:- initialization(server(5000)).

server(Port) :-
    http_set_session_options([
        timeout(86400  ), % Sessions last a day.
        cookie( session)  % Don't use the default session cookie name.
    ]),
    http_server(http_dispatch, [port(Port)]),
    refresh.

refresh :-
    make,
    sleep(5),
    refresh.
