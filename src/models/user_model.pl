:- module(user_model, [
    admin_role/1,
    user_role/1,
    
    check_level/2
]).

%   Authentication

user_level(user).
admin_level(admin).

check_level(Role, Level) :- (user_role(Role); admin_role(Role)), user_level(Level).
check_level(Role, Level) :- admin_role(Role), admin_level(Level).

user_role(user).

admin_role(admin).