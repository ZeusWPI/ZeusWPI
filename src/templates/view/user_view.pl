:- module(user_view, [users_view/1]).

:- use_module(library(http/html_write)).

:- use_module('../layout/page').

users_view(Users) :-
    page_(
        div([class='fixed-grid m-3 has-1-cols'], [
            div([class='notification is-info is-light'], [
                'An overview of the ', strong(['currently active sessions']), '. This app no longer uses a database for user storage, so more users than this will have access or will have interacted with this app in the past'
            ]),
            div([class='card'], [
                div([class='card-content'], [
                    table([class='table is-fullwidth'], [
                        thead(
                            tr([
                                th('Session ID'),
                                th('User ID'),
                                th('Name'),
                                th('Role'),
                                th('Idle Time')
                            ])
                        ),
                        tbody([
                            \users_view_(Users)
                        ])
                    ])
                ])
            ])
        ])
    ).

users_view_([]) --> html('').
users_view_([user(SessionID, ID, Name, Role, IdleTime)|Users]) -->
    html([
        tr([
            td(SessionID),
            td(ID),
            td(Name),
            %'oi',
            td(\role(Role)),
            td(IdleTime)
        ]),
        \users_view_(Users)
    ]).

role(user) --> html([span([class='tag is-light'], ['User'])]).
role(admin) --> html([span([class='tag is-dark'], ['Admin'])]).