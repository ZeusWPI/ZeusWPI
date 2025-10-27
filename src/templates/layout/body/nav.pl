:- module('nav', [nav//0]).

:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).
:- use_module(library(http/js_write)).

nav -->
    html([
        nav([class=navbar], [
            div([class='navbar-brand'], [
                a([class='navbar-item', href='https://github.com/ZeusWPI/ZeusWPI'], [
                    span([class='icon-text'], [
                        span([class='icon'], [
                            i([class='fas fa-image'], [])
                        ]),
                        span([strong(['PICS - Zeus WPI'])])
                    ])
                ]),
                a([class='navbar-burger', role='button', 'aria-label'='menu', 'data-target'='navbar-main'], [
                    span(['aria-hidden'='true'], []),
                    span(['aria-hidden'='true'], []),
                    span(['aria-hidden'='true'], []),
                    span(['aria-hidden'='true'], [])
                ])
            ]),
            div([class='navbar-menu', id='navbar-main'], [
                div([class='navbar-end'], [
                    \user_specific
                ])
            ]),
            \js_script({|javascript(_)||
                document.addEventListener('DOMContentLoaded', () => {
                    // Get all "navbar-burger" elements
                    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
                    // Add a click event on each of them
                    $navbarBurgers.forEach( el => {
                        el.addEventListener('click', () => {
                            // Get the target from the "data-target" attribute
                            const target = el.dataset.target;
                            const $target = document.getElementById(target);
                            // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
                            el.classList.toggle('is-active');
                            $target.classList.toggle('is-active');
                        });
                    });
                });
            |})
        ])
    ]).

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
        \nav_item(location_by_id(logout), 'fas fa-right-from-bracket', 'Logout')
    ]).
user_specific --> nav_item(location_by_id(login), 'fas fa-file', 'Login').

admin_stuff(admin) --> 
    html([
        \nav_item(location_by_id(users), 'fas fa-users-gear', 'Users'),
        \nav_item(location_by_id(new_upload), 'fas fa-upload', 'Upload')
    ]).
admin_stuff(_) --> html('').
