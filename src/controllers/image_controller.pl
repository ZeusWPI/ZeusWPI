:- module('image_controller', []).

:- use_module(library(http/http_client)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_session)).

:- use_module('../models/image_model').
:- use_module('../models/user_model').
:- use_module('../templates/layout/page').
:- use_module('../templates/view/image_view').
:- use_module('../util/random_atom').
:- use_module('../../config').

images(_Request) :-
    findall(
        image(FileName),
        get_image(FileName),
        Images
    ),
    images_view(Images).