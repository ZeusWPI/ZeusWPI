:- module('handlers', []).

:- use_module('controllers/login_controller').
:- use_module('controllers/main_controller').
:- use_module('controllers/user_controller').

:- http_handler(root(.)             , main_controller:index       , [id(main)]  ).

:- http_handler(root(login/start)   , login_controller:login      , [id(login)] ).
:- http_handler(root(login/callback), login_controller:callback   , []          ).
:- http_handler(root(login/logout)  , login_controller:logout     , [id(logout)]).

:- http_handler(root(users)         , admin(user_controller:users), [id(users)] ).
:- http_handler(root(user)          , login(user_controller:user) , [id(user)]  ).
