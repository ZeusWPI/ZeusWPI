:- module('login_controller', [login/2, admin/2]).

:- use_module(library(http/json)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_session)).
:- use_module(library(http/html_write)).

:- use_module('../../config').
:- use_module('../models/user_model').
:- use_module('../templates/layout/page').
:- use_module('../templates/view/require_auth_view').


login(Request) :-
    client_id(ClientId),
    redirect_uri(RedirectUri),
    atomic_list_concat([
        'https://adams.ugent.be/oauth/oauth2/authorize?response_type=code&state=oi&',
        'client_id=', ClientId, '&',
        'redirect_uri=', RedirectUri
    ], Uri),
    http_redirect(see_other, Uri, Request).

callback(Request) :-    
    % Catch thrown error to allow backtracking
    catch(http_parameters(Request, [code(Code, []), state(_, [])]), error(existence_error(_, _), _), fail),
    
    client_id(ClientId),
    client_secret(ClientSecret),
    redirect_uri(RedirectUri),
    Form = [
        code=Code,
        grant_type=authorization_code,
        client_id=ClientId,
        client_secret=ClientSecret,
        redirect_uri=RedirectUri
    ],
    http_post('https://adams.ugent.be/oauth/oauth2/token/', form(Form), Reply, []),
    atom_json_dict(Reply, Json, []),

    http_get('https://adams.ugent.be/oauth/api/current_user/', Data, [authorization(bearer(Json.get(access_token)))]),
    atom_json_dict(Data, UserData, []),
    (
        get_user(UserData.id, UserData.username, Role)
        ;
        (
            user_role(Role),
            add_user(UserData.id, UserData.username, Role)
        )
    ),
    http_session_assert(user(UserData.id, UserData.username, Role)),
    http_session_assert(alert(success, 'Login successful')),
    http_location_by_id(main, Location),
    http_redirect(see_other, Location, Request).
    

callback(Request) :-
    http_parameters(Request, [error(Error, []), error_description(Description, [optional(true)])]),
    (nonvar(Description) -> 
        page_([p(Error), p(Description)])
        ;
        page_([p(Error)])
    ).

logout(Request) :-
    http_session_retractall(user(_, _, _)),
    http_location_by_id(main, Location),
    http_redirect(see_other, Location, Request).

%   Some predicates to handle permissions levels.

login(Handler, Request) :-
    require_auth(user, Handler, Request).

admin(Handler, Request) :- 
    require_auth(admin, Handler, Request).

require_auth(Level, Handler, Request) :-
    (http_session_data(user(_, _, Role)) ->
        (check_level(Role, Level) ->
            call(Handler, Request)
            ;
            http_session_assert(alert(danger, 'In fact, you do not have access.')),
            no_auth_view('')
        )
        ;
        http_location_by_id(login, Location),
        http_redirect(see_other, Location, Request)
    ).
