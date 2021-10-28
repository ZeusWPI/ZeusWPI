:- module(upload_view, [upload_form/0]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

upload_form() :-
    page_(
        form([method='POST', action=location_by_id(upload), enctype='multipart/form-data'], [
            div(['uk-form-custom'], [
                input([type=file, name=file]),
                button([class='uk-button uk-button-default'], ['Select'])
            ]),
            input([class='uk-button uk-button-primary', type=submit, value='Upload'])
        ])    
    ).