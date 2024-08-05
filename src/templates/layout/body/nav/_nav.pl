:- module('nav', [user_specific//0, nav_item//3]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

:- use_module('../../../../util/current_app').
:- use_module('album').
:- use_module('cdn').

nav --> { current_app(album)}, html([ \album_nav ]).
nav --> { current_app(cdn) }, html([ \cdn_nav ]).
nav --> html('').

nav_item(Href, Icon, Content) -->
    html([
        div([class='navbar-item'], [
            div([class='buttons'], [
                a([class='button', href=Href], [
                    div([
                        span([class='icon'], [
                            i([class=Icon], [])
                        ]), 
                        span([Content])
                    ])
                ])
            ])
        ])
    ]).

user_specific --> 
    {http_session_data(user(_Id, _Name, Role))},
    html([
        \admin_stuff(Role),
        \nav_item(location_by_id(images), 'fas fa-image', 'Images'),
        \nav_item(location_by_id(documents), 'fas fa-file', 'Files'),
        \nav_item(location_by_id(albums), 'fas fa-file', 'Albums'),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
user_specific --> nav_item(location_by_id(login), 'fas fa-file', 'Login').

admin_stuff(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users'),
        \nav_item(location_by_id(new_upload), 'fas fa-upload', 'Upload')
    ]).
admin_stuff(_) --> html('').
