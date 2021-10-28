:- module('user_controller', []).

:- use_module(library(http/http_session)).

:- use_module('../models/user_model').
:- use_module('../templates/view/user_view').
:- use_module('../templates/layout/page').

users(_Request) :-
    findall(
        user(Id, Name, Role),
        get_user(Id, Name, Role),
        Users
    ),
    users_view(Users).