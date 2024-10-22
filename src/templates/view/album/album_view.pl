:- module(album_view, [album_view/3]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../../layout/page').
:- use_module('../../../models/album_model').
:- use_module('../../../models/image_model').

album_view(Album, Albums, Images) :-
    page_([
        div([class='columns'],  [
            \aside(Album, Albums),
            div([class='column is-10 pl-0'], [
                \images(Album, Images)
            ])    
        ])
    ]).

aside(Album, Albums) -->
    {
        album_id(Album, Id),
        album_title(Album, Title),
        http_link_to_id(album_upload, path_postfix(Id), UploadUrl)
    },
    html([
        div([class='column is-2'], [
            div([class='card'], [
                header([class='card-header'], [
                    p([class='card-header-title is-capitalized'], [Title])
                ]),
                div([class='card-content'], [
                    div([class='fixed-grid has-1-cols'], [
                        div([class='grid'], [
                            div([class='cell'], [
                                a([class='button is-fullwidth', href=UploadUrl], [
                                    div([
                                        span([class='icon'], [
                                            i([class='fas fa-upload'], [])
                                        ]), 
                                        span(['Upload'])
                                    ])
                                ])
                            ]),
                            div([class='cell'], [
                                a([class='button is-fullwidth is-danger', href='#', disabled], [
                                    div([
                                        span([class='icon'], [
                                            i([class='fas fa-upload'], [])
                                        ]), 
                                        span(['Delete'])
                                    ])
                                ])
                            ])
                        ])
                    ])  
                ])
            ]),
            \aside_albums(Album, Albums)
        ])
    ]).

aside_albums(Album, Albums) -->
    {
        album_id(Album, Id),
        http_link_to_id('album_new', path_postfix(Id), Url)
    },
    html([
        div([class='card'], [
            header([class='card-header'], [
                div([class='card-header-title'], [
                    span([class='icon'], [
                        i([class='fas fa-images'], [])
                    ]), 
                    span(['Albums'])                    
                ])
            ]),
            div([class='card-content'], [
                div([class='fixed-grid has-1-cols'], [
                    div([class='grid'], [
                        \aside_albums_list(Path, Albums),
                        form([class=form, method='POST', action=Url], [
                            div([class='cell mt-5'], [
                                div([class=field],[
                                    div([class=control], [
                                        input([class='input', type=text, name=title, placeholder='Title'])
                                    ])
                                ]),
                                div([class=field],[
                                    div([class=control], [
                                        button([class='button is-fullwidth', type=submit], [
                                            div([
                                                span([class='icon'], [
                                                    i([class='fas fa-plus'], [])
                                                ]), 
                                                span(['New Album'])
                                            ])
                                        ])
                                    ])
                                ])
                            ])
                        ])
                    ])
                ])
            ])
        ])
    ]).

aside_albums_list(_   , []            ) --> html('').
aside_albums_list(Path, [Album|Albums]) --> 
    {
        album_id(Album, Id),
        album_title(Album, Title),
        http_link_to_id(albums, path_postfix(Id), Url)
    },
    html([
        div([class='cell'], [
            a([class='button is-fullwidth', href=Url, style='height: max-content; white-space: inherit'], [
                div([class='is-capitalized'], [
                    Title
                ])
            ])
        ]),
        \aside_albums_list(Path, Albums)
    ]).

images(_   , []    ) --> html('').
images(Album, Images) -->
    { length(Images, Length), Length > 0 },
    html([
        div([class='fixed-grid has-8-cols-fullhd has-6-cols-widescreen has-4-cols-desktop has-2-cols-tablet has-1-cols-mobile'], 
            div([class='grid'], [
                \image_list(Album, Images)
            ])
        )
    ]).


image_list(_, []) --> html('').
image_list(Album, [Image|Images]) --> 
    {
        image_id(Image, Id),
        http_link_to_id(album_image, path_postfix(Id), Url)
        
    },
    html([
        div([class='cell'], [
            div([class='card'], [
                div([class='card-image'], [
                    figure([class='image is-3by4'], [
                        img([src=Url, style='object-fit: cover;'], [])
                    ])
                ])
            ])
        ]),
        \image_list(Path, Images) 
    ]).