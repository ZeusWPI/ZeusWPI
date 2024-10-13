:- module('album_controller', []).

:- use_module('../models/album_model').
:- use_module('../templates/view/album/album_view').

albums(Request) :-
    (
        member(path_info(Path), Request)
        ;
        Path = ''
    ),
    get_albums(Path, Albums),
    get_album_images(Path, Images),
    album_view(Path, Albums, Images),
    write(Path), nl,
    write(Request), nl.