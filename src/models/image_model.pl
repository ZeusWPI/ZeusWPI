:- module(image_model, [get_image/1]).

:- use_module('../../config').

get_image(FileName) :-
    directory_files('files', Entries),
    content_type(_, Extension),
    member(FileName, Entries),
    atom_concat(_, Extension, FileName).

% add_image(FileName) :-
%     assert_image(UploaderId, FileName).