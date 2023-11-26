# ZeusWPI

Zeus Extraordinary Uploading Service With Productive (Prolog) Interface

## Development

Install SWI-Prolog using [asdf](https://asdf-vm.com/).

```sh
asdf install
```

This project relies on Redis for performant session storage.
You can start an instance using the provided `docker-compose.devel.yml` file.

Next create the required directories.

```sh
mkdir -p {data,files}
```

Then start the development (Live reload) server using:

```sh
swipl src/main.pl devel 5000
```

Or run the above steps by running `make devel`.

Visit your browser at [http://localhost:5000](http://localhost:5000).

## Deployment

The deployment setup is contained in the provided `docker-compose.yml` file.

There are 3 environment variables to change:

| Key                   | Value                                           |
| --------------------- | ----------------------------------------------- |
| ZEUSWPI_CLIENT_ID     | The OAUTH Client ID                             |
| ZEUSWPI_CLIENT_SECRET | The OAUTH Secret                                |
| ZEUSWPI_REDIRECT_URI  | The OAUTH Redirect URI (Set the correct domain) |

You also need to create the required directories in this mode. As these will be mounted as volumes in the container.

```sh
mkdir -p {data,files}
```

Then start with:

```sh
docker compose up -d
```

## Adding admins

First the person you want make an admin has to log in to the application once. 
Then on the server find the user fact in the database `data/user.db`

```prolog
assert(user(69,"the_admin",user)).
```

and update the record to

```prolog
assert(user(69,"the_admin",admin)).
```

then restart the application.
