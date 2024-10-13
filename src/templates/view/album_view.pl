:- module(album_view, [album_view/3]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

album_view(Path, Albums, Images) :-
    page_(
        div([class='columns'],  [
            \aside(Path, Albums),
            div([class='column is-10 pl-0'], [
                \images(Path, Images)
            ])    
        ])
    ).

aside(Path, Albums) -->
    {
        atom_concat(NPath, '/', Path),
        atomic_list_concat(PathParts, '/', NPath),
        last(PathParts, CurrentAlbum)
    },
    html([
        div([class='column is-2'], [
            
            div([class='card'], [
                header([class='card-header'], [
                    p([class='card-header-title is-capitalized'], [CurrentAlbum])
                ]),
                div([class='card-content'], [
                    div([class='fixed-grid has-1-cols'], [
                        div([class='grid'], [
                            div([class='cell'], [
                                a([class='button is-fullwidth', href='#', disabled], [
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
            \aside_albums(Path, Albums)
        ])
    ]).

aside_albums(Path, Albums) -->
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
                        div([class='cell mt-5'], [
                            a([class='button is-fullwidth', href='#', target='_blank', onclick='window.open(\'#\', \'newwindow\', \'width=1000,height=800\'); return false;', disabled], [
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
    ]).

aside_albums_list(_   , []            ) --> html('').
aside_albums_list(Path, [Album|Albums]) --> 
    {
        http_location_by_id(albums, Location),
        atom_concat(Location, Path, Lp),
        atom_concat(Lp, Album, Lpa),
        atom_concat(Lpa, /, Url)
    },
    html([
        div([class='cell'], [
            a([class='button is-fullwidth', href=Url], [
                div([class='is-capitalized'], [
                    Album
                ])
            ])
        ]),
        \aside_albums_list(Path, Albums)
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