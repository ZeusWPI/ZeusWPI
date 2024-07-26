:- module(album_view, [album_view/3]).

:- use_module(library(http/html_write)).
:- use_module(library(http/http_dispatch)).

:- use_module('../layout/page').

album_view(Path, Albums, Images) :-
    page_(
        div([
            div([class='fixed-grid has-2-cols-fullhd has-2-cols-widescreen has-2-cols-desktop has-1-cols-tablet has-1-cols-mobile'], 
                div([class='grid m-3'], [
                    \albums(Path, Albums)
                ])
            ),
            div([class='fixed-grid has-8-cols-fullhd has-6-cols-widescreen has-4-cols-desktop has-2-cols-tablet has-1-cols-mobile'], 
                div([class='grid m-3'], [
                    \images(Path, Images)
                ])
            )
        ])
    ).

albums(_   , []            ) --> html('').
albums(Path, [Album|Albums]) -->
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
                            p([class='is-4'], Album)
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
        \albums(Path, Albums)
    ]).

images(_, []) --> html('').
images(Path, [Image|Images]) --> 
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
        \images(Path, Images) 
    ]).