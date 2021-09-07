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

new(_Request) :-
    upload_form.

upload(Request) :-
    http_read_data(Request, Parts, [form_data(mime)]),
	member(mime(Attributes, Data, []), Parts),
	
    memberchk(name(file), Attributes),

    % Filter allowed content type
    member(type(Type), Attributes),
    (content_type(Type, Extension) ->
        generated_file_length(Length),
        random_atom(Length, Atom),
        atom_concat(Atom, Extension, FileName),
        atom_concat('files/', FileName, Path),
    
        open(Path, write, FileStream, [type(binary)]),
        write(FileStream, Data),
        close(FileStream),
        
        atom_concat('/', FileName, Location),
        http_redirect(see_other, Location, Request)
        ;
        page_("The facts don't line out. Check your filetype and try again.")
    ).