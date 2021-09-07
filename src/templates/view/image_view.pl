:- module(image_view, [images_view/1, upload_form/0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

images_view(Images) :-
    http_location_by_id(files, FileLocation),
    page_(
        div([class='uk-grid-medium uk-child-width-1-4@xl uk-child-width-1-3@l uk-child-width-1-2@m uk-child-width-1-1@s uk-text-bold', 'uk-grid'='masonry: true'], [
            \list_elements(Images, FileLocation)
        ])
    ).

list_elements([], _) --> html('').
list_elements([image(FileName)|Images], FileLocation) --> 
    {
        atom_concat(FileLocation, FileName, Uri) 
    },
    html([
        div(div([class='uk-card uk-card-default'], [
            div([class='uk-card-body'], [
                img(['data-src'=Uri, width='', height='', alt='', 'uk-img'], [])
            ]),
            div([class='uk-card-footer'], [
                a([class='uk-button uk-button-text', href=Uri], ['Open'])
            ])
        ])), 
        \list_elements(Images, FileLocation)
    ]).

upload_form() :-
    page_(
        form([method='POST', action=location_by_id(upload_image), enctype='multipart/form-data'], [
            div(['uk-form-custom'], [
                input([type=file, name=file]),
                button([class='uk-button uk-button-default'], ['Select'])
            ]),
            input([class='uk-button uk-button-default', type=submit, value='Upload'])
        ])    
    ).

