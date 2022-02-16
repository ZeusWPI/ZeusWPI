:- module(config, [
    client_id/1,
    client_secret/1,

    redirect_uri/1,
    content_type/2,
    generated_file_length/1
]).

% If client id is not in env, use development default.
client_id(Id) :- getenv('ZEUSWPI_CLIENT_ID', Id), !.
client_id(tomtest).

% If client secret is not in env, use development default.
client_secret(Secret) :- getenv('ZEUSWPI_CLIENT_SECRET', Secret), !.
client_secret(blargh).

% If redirect uri is not in env, use development default.
redirect_uri(Uri) :- getenv('ZEUSWPI_REDIRECT_URI', Uri), !.
redirect_uri('http://localhost:5000/login/callback').

content_type('image/gif'    , '.gif').
content_type('image/jpeg'   , '.jpg').
content_type('image/png'    , '.png').
content_type('image/svg+xml', '.svg').

content_type('application/zip', '.zip').
content_type('application/pdf', '.pdf').

generated_file_length(40).