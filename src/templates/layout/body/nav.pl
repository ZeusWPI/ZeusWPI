:- module('nav', [nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

nav -->
    html([
        nav([class='uk-navbar-container', 'uk-navbar'], [
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
        \admin_link(Role),
        \nav_item(location_by_id(images), 'Images'),
        \nav_item(location_by_id(user), Name),
        \nav_item(location_by_id(logout), 'Logout')
    ]).
user_specific --> nav_item(location_by_id(login), 'Login').

admin_link(admin) --> 
    html(
        li([
            a([href='#'], ['Admin']),
            div([class='uk-navbar-dropdown'], [
                ul([class='uk-nav uk-navbar-dropdown-nav'], [
                    \nav_item(location_by_id(users), 'Users')
                ])
            ])
        ])
    ).
admin_link(_) --> html('').
