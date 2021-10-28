:- module(image_model, [get_image/1]).

:- use_module('../../config').

get_image(FileName) :-
    directory_files('files', Entries),
    content_type(Type, Extension),
    atom_concat('image', _, Type),
    member(FileName, Entries),
    atom_concat(_, Extension, FileName).