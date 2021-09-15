:- module('handlers', []).

:- use_module(library(http/http_files)).

:- use_module('controllers/file_controller').
:- use_module('controllers/image_controller').
:- use_module('controllers/login_controller').
:- use_module('controllers/main_controller').
:- use_module('controllers/upload_controller').
:- use_module('controllers/user_controller').

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(files, root(.), []).

:- http_handler(root(.)             , main_controller:index             , [id(main)]  ).

:- http_handler(root(login/start)   , login_controller:login            , [id(login)] ).
:- http_handler(root(login/callback), login_controller:callback         , []          ).
:- http_handler(root(login/logout)  , login_controller:logout           , [id(logout)]).

:- http_handler(root(files)         , login(file_controller:files)          , [id(documents)]).
:- http_handler(root(images)        , login(image_controller:images)    , [id(images)]).
:- http_handler(root(upload/new)    , admin(upload_controller:new)      , [id(new_upload), method(get)]).
:- http_handler(root(upload)        , admin(upload_controller:upload)   , [id(upload), method(post)]).

% Replace with nginx?
:- http_handler(files(.)            , http_reply_from_files('files', []), [prefix, id(files)]).

:- http_handler(root(users)         , admin(user_controller:users)      , [id(users)] ).
:- http_handler(root(user)          , login(user_controller:user)       , [id(user)]  ).
