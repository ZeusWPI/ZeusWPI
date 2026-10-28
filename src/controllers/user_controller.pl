:- module('user_controller', []).

:- use_module(library(http/http_session)).

:- use_module('../models/user_model').
:- use_module('../templates/view/user_view').
:- use_module('../templates/layout/page').

users(_Request) :-

    findall(
        user(SessionID, ID, Name, Role, IdleTime),
        (   
            http_current_session(SessionID, user(ID, Name, Role)),            http_current_session(SessionID, idle(IdleTime))
        ),
        Users
    ),
    users_view(Users).