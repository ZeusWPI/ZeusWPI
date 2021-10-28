:- module(file_view, [files_view/1]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

files_view(FileNames) :-
    http_location_by_id(files, FileLocation),
    page_(
        table([class='uk-table uk-table-striped'], [
            thead(
                tr([
                    th('FileName'),
                    th('')
                ])   
            ),
            tb(
                \list_elements(FileNames, FileLocation)
            )
        ])
    ).

list_elements([], _) --> html('').
list_elements([FileName|FileNames], FileLocation) --> 
    {
        atom_concat(FileLocation, FileName, Uri) 
    },
    html([
        tr([
            td(FileName),
            td(a([class='uk-button uk-button-primary', href=Uri], ['Open']))
        ]),
        \list_elements(FileNames, FileLocation)
    ]).