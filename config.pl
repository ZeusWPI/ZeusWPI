:- module(config, [
    client_id/1,
    client_secret/1,

    redirect_uri/1,
    allowed_image_formats/1
]).

client_id(tomtest).
client_secret(blargh).

redirect_uri('http://localhost:5000/login/callback').

allowed_image_formats(Extension) :- 
    member(Extension, ['.png', '.jpg', '.svg', '.jpeg', '.gif', '.ico']).