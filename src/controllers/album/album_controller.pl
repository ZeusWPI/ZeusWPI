:- module('album_controller', []).

:- use_module(library(http/http_client)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../models/album_model').
:- use_module('../../models/image_model').
:- use_module('../../templates/view/album/album_view').
:- use_module('../../templates/view/album/upload_view').
:- use_module('../../../config').
:- use_module('../../templates/layout/page').
:- use_module('../../util/random_atom').

list('', Request) :- list(none, Request).
list(none, Request) :- 
    album_children(none, Albums),
    album_view(album(none, 'A', 'A', none), Albums, []).
list(Id, Request) :-
    (album_by_id(Id, Album) ->
        album_children(Id, Albums),
        images_by_album(Id, Images),
        album_view(Album, Albums, Images)
        ;
        fail
    ).

upload(get, Id, Request) :-
    upload_view().

upload(post, Id, Request) :-
    (album_by_id(Id, Album) ->

        http_read_data(Request, Parts, [form_data(mime)]),
        member(mime(Attributes, Data, []), Parts),
        
        memberchk(name(file), Attributes),

        % Filter allowed content type
        member(type(Type), Attributes),
        (content_type(Type, Extension) ->
            generated_file_length(Length),
            random_atom(Length, Atom),
            album_storage(Id, AlbumPath),
            atom_concat(Atom, Extension, FileName),

            atom_concat(AlbumPath, FileName, Path),
        
            open(Path, write, FileStream, [type(binary)]),
            write(FileStream, Data),
            close(FileStream),

            new_image(image(_, Id, Path, none)),
            
            page_(ok)
            ;
            atom_concat('The facts dont line out. Check your filetype and try again. Type: ', Type, String3),
            page_(String3)
        )
        ;
        fail
    ).

image(Id, Request) :-
    (image_by_id(Id, Image) ->
        image_original(Image, Original),
        http_reply_file(Original, [cache(true)], Request)        
        ;
        fail
    ).