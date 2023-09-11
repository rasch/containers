# pijul

Run [pijul] in a container

## configuration

The configuration files are stored at `"$HOME"/.config/xpod/pijul`. This is
where identities are created when running `pijul identity` commands, and should
probably be backed up. These identities are used for signing `pijul record`s
(as opposed to `git` using `gpg` for signing commits/tags). A user global
configuration file can be placed in `"$HOME"/.config/xpod/pijul/config.toml`
if needed.

This container is configured to use GnuPG auth keys for SSH authentication and
needs access to the auth key for working with remote repositories. The
`gnupg` directory location can be configured using environment variables (in
`.bashrc` or `.profile` or similar). For example:

```sh
export GPG_DIR="$HOME"/.gnupg
# or
export GNUPGHOME="$HOME"/.config/gnupg
```

If the directory `"$HOME"/.config/xpod/gnupg` exists, it will be used as a
fallback when `GPG_DIR` or `GNUPGHOME` are not set. If no `gnupg` directory
is found, then authentication for working with remotes will require using a
password.

## getting started

Most people will probably want to use remote repositories for collaboration and
should probably create an account on [The Nest]. Then use `pijul identity new`
to create an identity and `pijul identity prove` to link the identity to the
remote. For more usage instructions, check out the [pijul] website and don't
forget about `pijul help [command]`.

## notes

Since `pijul` is running in a container, and only mounts the current working
directory into the container, all `pijul` commands must be run from the root of
a repository (except `init` since it creates the repository). Running `pijul`
in a subdirectory of the project won't work, because the `.pijul` directory
won't be mounted in the container.

[pijul]: https://pijul.org/
[The Nest]: https://nest.pijul.com/
