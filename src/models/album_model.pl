:- module(album_model, [get_albums/2, get_album_images/2]).

:- use_module('../../config').

get_albums(ParentTree, Albums) :-
    atom_concat('albums/', ParentTree, SearchDir),
    directory_files(SearchDir, Entries),
    findall(Entry, (
        member(Entry, Entries),
        \+ member(Entry, ['.', '..']), 
        atom_concat(SearchDir, Entry, Path), 
        exists_directory(Path)
    ), Albums).

get_album_images(ParentTree, Images) :-
    atom_concat('albums/', ParentTree, SearchDir),
    directory_files(SearchDir, Entries),
    findall(FileName, (
        content_type(Type, Extension),
        atom_concat('image', _, Type),
        member(FileName, Entries),
        atom_concat(_, Extension, FileName)
    ), Images).