:- module('nav', [nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

nav -->
    html([
        nav([class='uk-navbar-container uk-background-primary uk-navbar-transparent uk-light', 'uk-navbar'], [
            div([class='uk-navbar-left'], [
                a([class='uk-navbar-item uk-logo', href='#'], ['ZeusWPI'])
            ]),
            div([class='uk-navbar-right'], [
                ul([class='uk-navbar-nav'], [
                    \user_specific
                ])
            ])
        ])
    ]).

nav_item(Href, Content) -->
    html([
        li(
            a([href=Href], [Content])
        )
    ]).

user_specific --> 
    {http_session_data(user(_Id, Name, Role))},
    html([
        \admin_stuff(Role),
        \nav_item(location_by_id(images), 'Images'),
        \nav_item(location_by_id(documents), 'Files'),
        \nav_item(location_by_id(logout), 'Logout')
    ]).
user_specific --> nav_item(location_by_id(login), 'Login').

admin_stuff(admin) --> 
    html([
        \nav_item(location_by_id(users), 'Users'),
        \nav_item(location_by_id(new_upload), 'Upload')
    ]).
admin_stuff(_) --> html('').
