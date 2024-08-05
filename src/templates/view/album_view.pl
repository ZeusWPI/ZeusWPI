:- module(album_view, [album_view/3]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

album_view(Path, Albums, Images) :-
    page_(
        div([class='columns'],  [
            \aside,
            div([class='column is-10 pl-0'], [
                \albums(Path, Albums),
                \images(Path, Images)
            ])    
        ])
    ).

aside -->
    html([
        div([class='column is-2'], [
            div([class='card'], [
                header([class='card-header'], [
                    p([class='card-header-title'], ['The Album Name'])
                ]),
                div([class='card-content'], [
                    div([class='fixed-grid has-1-cols'], [
                        div([class='grid'], [
                            div([class='cell'], [
                                a([class='button is-fullwidth', href='#', target='_blank', onclick='window.open(\'#\', \'newwindow\', \'width=1000,height=800\'); return false;'], [
                                    div([
                                        span([class='icon'], [
                                            i([class='fas fa-upload'], [])
                                        ]), 
                                        span(['New Album'])
                                    ])
                                ])
                            ]),
                            div([class='cell'], [
                                a([class='button is-fullwidth', href='#'], [
                                    div([
                                        span([class='icon'], [
                                            i([class='fas fa-upload'], [])
                                        ]), 
                                        span(['Upload'])
                                    ])
                                ])
                            ]),
                            div([class='cell'], [
                                a([class='button is-fullwidth is-danger', href='#'], [
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
            ])
        ])
    ]).

albums(_   , []    ) --> html('').
albums(Path, Albums) -->
    { length(Albums, Length), Length > 0 },
    html([
        div([class='fixed-grid has-2-cols-fullhd has-2-cols-widescreen has-2-cols-desktop has-1-cols-tablet has-1-cols-mobile'], 
            div([class='grid'], [
                \album_list(Path, Albums)
            ])
        )
    ]).

album_list(_   , []            ) --> html('').
album_list(Path, [Album|Albums]) -->
    {
        http_location_by_id(albums, Location),
        atom_concat(Location, Path, Lp),
        atom_concat(Lp, Album, Lpa),
        atom_concat(Lpa, /, Url)
    },
    html([
        div([class='cell'], [
            div([class='card'], [
                div([class='card-content'], [
                    div([class='columns'], [
                        div([class='column'], [
                            div([class='card'], [
                                div([class='card-image'], [
                                    figure([class='image is-16by9'], [
                                        img([src='http://localhost:5000/albums/i/test-1/PXL_20240328_190953504.jpg', style='object-fit: cover'],[]) % TODO: dynamic image
                                    ])
                                ])
                            ])
                        ]),
                        div([class='column'], [
                            p([class='is-size-4 is-capitalized'], Album)
                        ])
                    ])
                ])                ,
                footer([class='card-footer'], [
                    a([class='card-footer-item', href=Url], 'Open'),
                    a([class='card-footer-item', href='#'], 'Share'),
                    a([class='card-footer-item', href='#'], 'Delete')
                ])
            ])
        ]),
        \album_list(Path, Albums)
    ]).

images(_   , []    ) --> html('').
images(Path, Images) -->
    { length(Images, Length), Length > 0 },
    html([
        div([class='fixed-grid has-8-cols-fullhd has-6-cols-widescreen has-4-cols-desktop has-2-cols-tablet has-1-cols-mobile'], 
            div([class='grid'], [
                \image_list(Path, Images)
            ])
        )
    ]).

image_list(_, []) --> html('').
image_list(Path, [Image|Images]) --> 
    {
        http_location_by_id('ablum_images', Location),
        atom_concat(Location, Path, Lp),
        atom_concat(Lp, Image, Url)
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