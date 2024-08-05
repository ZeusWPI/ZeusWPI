:- module('album_nav', [album_nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

album_nav -->
    html([
        nav([class=navbar], [
            div([class='navbar-brand'], []),
            div([class='navbar-menu'], [
                div([class='navbar-start'], [
                    \start
                ]),
                div([class='navbar-end'], [
                    \end
                ])
            ])
        ])
    ]).

start -->
    {http_session_data(user(_Id, _Name, _Role))},
    html([
        \nav_item(location_by_id(albums), 'fas fa-file', 'Albums')
    ]).
start --> html('').

end --> 
    {http_session_data(user(_Id, _Name, _Role))},
    html([
        \nav_item(location_by_id(images), 'fas fa-file', 'Goto CDN'),
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
end --> nav_item(location_by_id(login), 'fas fa-file', 'Login').