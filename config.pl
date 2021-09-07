:- module(config, [
    client_id/1,
    client_secret/1,

    redirect_uri/1,
    content_type/2,
    generated_file_length/1
]).

client_id(tomtest).
client_secret(blargh).

redirect_uri('http://localhost:5000/login/callback').

content_type('image/gif'    , '.gif').
content_type('image/jpeg'   , '.jpg').
content_type('image/png'    , '.png').
content_type('image/svg+xml', '.svg').

generated_file_length(40).