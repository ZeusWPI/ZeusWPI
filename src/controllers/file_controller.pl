:- module('file_controller', []).

:- use_module('../models/file_model').
:- use_module('../templates/view/file_view').

files(_Request) :-
    findall(
        FileName,
        get_file(FileName),
        Files
    ),
    files_view(Files).