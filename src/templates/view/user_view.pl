:- module(user_view, [users_view/1, user_view/1]).

:- use_module(library(http/html_write)).

:- use_module('../layout/page').

users_view(Users) :-
    page_(
        div([class='uk-card uk-card-default uk-card-body'], [
            table([class='uk-table uk-table-divider'], [
                thead(
                    tr([
                        th('Id'),
                        th('Name'),
                        th('Role')
                    ])
                ),
                tbody([
                    \users_view_(Users)
                ])
            ])
        ])
    ).

users_view_([]) --> html('').
users_view_([user(Id, Name, Role)|Users]) -->
    html([
        tr([
            td(Id),
            td(Name),
            td(Role)
        ]),
        \users_view_(Users)
    ]).

user_view(user(Id, Name, Role)) :-
    page_(
        div([class='uk-grid-medium uk-child-width-1-4@xl uk-child-width-1-3@l uk-child-width-1-2@m uk-child-width-1-1@s uk-text-center uk-text-bold', 'uk-grid'], [
            div(\property_card('Id', Id)),
            div(\property_card('Name', Name)),
            div(\property_card('Role', Role)),
            div(\property_card('Orders', 140))
        ])
    ).

property_card(Name, Value) -->
    {
        random_member(Style, [default, primary, secondary]),
        atom_concat('uk-card uk-card-default uk-card-body uk-card-hover uk-card-', Style, Class)
    },
    html([
        div([class=Class], [
            div([class='uk-grid-divider uk-child-width-expand', 'uk-grid'], [
                div(Name),
                div(Value)
            ])
        ])
    ]).