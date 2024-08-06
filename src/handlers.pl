:- module('handlers', []).

:- use_module(library(http/http_files)).
:- use_module(library(http/http_stream)).

:- use_module('controllers/album_controller').
:- use_module('controllers/file_controller').
:- use_module('controllers/image_controller').
:- use_module('controllers/login_controller').
:- use_module('controllers/main_controller').
:- use_module('controllers/upload_controller').
:- use_module('controllers/user_controller').

%:- use_module('controllers/status_page').

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(files, root(.), []).

:- http_handler(root(.)             , main_controller:index             , [id(main)]  ).

:- http_handler(root(login/start)   , login_controller:login            , [id(login)] ).
:- http_handler(root(login/callback), login_controller:callback         , []          ).
:- http_handler(root(login/logout)  , login_controller:logout           , [id(logout)]).

:- http_handler(root(files)         , login(file_controller:files)                     , [id(documents)   , app(cdn)]                ).
:- http_handler(root(images)        , login(image_controller:images)                   , [id(images)      , app(cdn)]                ).
:- http_handler(root('albums/l/')   , login(album_controller:albums)                   , [id(albums)      , prefix      , app(album)]).
:- http_handler(root('albums/i/')   , http_reply_from_files('albums', [not_found(404)]), [id(ablum_images), prefix      , app(album)]).
:- http_handler(root(upload/new)    , admin(upload_controller:new)                     , [id(new_upload)  , method(get) , app(cdn)]  ).
:- http_handler(root(upload)        , admin(upload_controller:upload)                  , [id(upload)      , method(post), app(cdn)]  ).

% Replace with nginx?
:- http_handler(files(.)            , http_reply_from_files('files', [not_found(404)]), [prefix, id(files)]).
:- http_handler(root('assets/')     , http_reply_from_files('src/assets', [not_found(404)]), [prefix, id(assets)]).
% :- http_handler(root(assets)        , write, [prefix, id(assets)]).

:- http_handler(root(users)         , admin(user_controller:users)      , [id(users)] ).


% Request expansions

:- http_request_expansion(save_app, 100 ).
:- http_request_expansion(sync    , 1000). % Should be handled last

save_app(RO, [app(App)|RO], Options) :-
    member(app(App), Options).

sync(R, R, _) :-
    current_output(CGI),
    cgi_set(CGI, request(R)).