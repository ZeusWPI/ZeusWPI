:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_session)).

:- use_module('handlers').

:- initialization(main).

main :- 
    (current_prolog_flag(argv, [Mode, Port]) ->
        (atom_number(Port, PortNr) ->
            main(Mode, PortNr)
            ;
            usage, halt(1)
        )
        ;
        usage, halt(1)
    ).
main(devel, Port) :-
    write("Mode: Development"), nl,
    write("Port: "), write(Port), nl,
    server(Port, (make, sleep(5))).
main(prod, Port) :-
    write("Mode: Production"), nl,
    write("Port: "), write(Port), nl,
    server(Port, sleep(100)).

server(Port, After) :-
    http_set_session_options([
        timeout(86400  ), % Sessions last a day.
        cookie( session)  % Don't use the default session cookie name.
    ]),
    http_server(http_dispatch, [port(Port)]),
    busy(After).

% Print usage.
usage :- write("Usage: swipl src/main.pl [prod|devel] PORT"), nl.

% Infinitly keep backtracking the After Goal.
busy(After) :-
    repeat,
    call(After),
    fail.
