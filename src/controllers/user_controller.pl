:- module('user_controller', []).

:- use_module(library(http/http_session)).

:- use_module('../models/user_model').
:- use_module('../templates/view/user_view').
:- use_module('../templates/layout/page').

users(_Request) :-
    findall(
        User, 
        (
            get_user(Id, Name, Role), User = user(Id, Name, Role)
        ),
        Users
    ),
    users_view(Users).

user(_Request) :-
    User = user(Id, Name, Role),
    http_session_data(user(Id, Name, Role)),
    user_view(User).