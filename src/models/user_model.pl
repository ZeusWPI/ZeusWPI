:- module(user_model, [
    admin_role/1,
    user_role/1,

    check_level/2,

    get_user/3, 
    add_user/3
]).

:- use_module(library(persistency)).

:- persistent user(
    id: integer,
    name: string,
    role: oneof([user, admin])).

:- initialization(db_attach('user.db', [])).

get_user(Id, Name, Role) :-
    user(Id, Name, Role).

add_user(Id, Name, Role) :-
    assert_user(Id, Name, Role).


%   Authentication

user_level(user).
admin_level(admin).

check_level(Role, Level) :- (user_role(Role); admin_role(Role)), user_level(Level).
check_level(Role, Level) :- admin_role(Role), admin_level(Level).

user_role(user).

admin_role(admin).