# darkhttpd

[darkhttpd] is a tiny static web server that is useful for local devlopment.

## Usage

The option and port handling for running `darkhttpd` with this script slightly
differ from the standalone binary.

In order to run `darkhttpd` in a container, the exposed ports have to be managed
by `podman`/`docker` and the same port has to be used with `darkhttpd`. This
script handles port mapping through an environment variable, `PORT`.

```sh
# runs on port 3000 by default
darkhttpd

# run on port 5150
PORT=5150 darkhttpd
```

This script runs `darkhttpd` in a container and sets the current working
directory of the host as the working directory in the container. Unless
arguments are given, `darkhttpd` serves the current directory (`.`). If serving
a directory other than the current, it must still be a child (subdirectory) of
it.

For additional documentation on running `darkhttpd` see the help page:
`darkhttpd --help`

An additional script `darkhttpd-daemon` is included to run `darkhttpd` as a
background service. Using the `--daemon` option causes the container to exit
immediately, so this script instead runs `darkhttpd` in a detached container.

[darkhttpd]: https://github.com/emikulic/darkhttpd
