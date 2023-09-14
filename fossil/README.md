# fossil

[Fossil] stores repositories in SQLite databases as opposed to Git using the
filesystem (the `.git` directory). Usually the Fossil repositories are stored in
a different directory (the **museum**) than the checkout. When using this
container, it is recommended to keep all of the repositories in the `MUSEUM`
directory, mounted in the container at `/museum`. The current working directoy
should always be the root of the fossil checkout when running Fossil commands
otherwise the `.fslckout` might not be mounted in the container.

Here are a few examples to get started.

```sh
# start with a fresh directory, `ivxl` for the examples
mkdir ivxl
cd ivxl

# clone repo to **museum** (note the /museum prefix before the destination)
fossil clone https://chiselapp.com/user/rasch/repository/ivxl /museum/ivxl.fossil
fossil open /museum/ivxl.fossil

# or if you want to work more like Git (repo and checkout in same directory)
fossil clone https://chiselapp.com/user/rasch/repository/ivxl .fsl
fossil open --force .fsl
```

> Note: The repo in the examples above is just a little TypeScript module that
> was used to test out Fossil in this container (and also
> [Bun](https://bun.sh/)). It's just a little Roman Numeral to Integer
> converter.

## Configuration

Global configuration is stored at `"$HOME"/.config/xpod/fossil/fossil.db`, so
running `fossil settings --global` commands will be persistent.

### Environment Variables

#### FOSSIL_USER

The variable `FOSSIL_USER` can be used to set the Fossil user. `$USER` or
`$(whoami)` will be used as fallbacks.

#### MUSEUM

The **museum** for Fossil repositories is configured using the `MUSEUM`
variable. If not set, then `"$HOME"/.config/xpod/fossil/museum` is used. This
directory is mounted at `/museum` in the container.

#### FOSSIL_GPG_DIR

{optional} To enable clearsigning manifests with `gpg`:

```sh
fossil settings --global clearsign true
```

Then set the path to the `gnupg` directory to mount in the container using one
of the following variables:

- `FOSSIL_GPG_DIR`
- `GPG_DIR`
- `GNUPGHOME`
- `"$HOME"/.config/xpod/gnupg` will be used if none of the previous are set.

## Running Fossil Server in Container

When running `fossil server` as root, Fossil drops itself into a chroot jail.
The chroot jailed server is not accessible outside of the container. Using the
`xpod -u` option here to set the user in the container prevents this issue, but
causes write/ownership problems. This just means `fossil server` has to use the
`--nojail` option and `fossil ui` doesn't work because it is bound to localhost
inside the container. The variable `PORT` is used to specify a port to use for
`fossil serve` and is published on the same port by the container. Don't
permanently set the `PORT` variable in the shell profile! That would only allow
one `fossil` container to run at a time, so `fossil` commands wouldn't be able
to run while the server is running (because the port is already taken). If the
`PORT` variable is set, then the `--nojail` flag is appended to the `fossil`
options.

```sh
# serve a single repository locally
PORT=3000 fossil server
PORT=3000 fossil server /museum/ivxl.fossil

# serve all repositories
PORT=3000 fossil server --repolist /museum
```

After running one of the above `server` commands, visit `[local IP]:[PORT]` in a
web browser (for example "192.168.1.101:3000").

## Fossil Backup (sort of)

See [Backing Up a Remote Fossil Repository][backup] on the Fossil wiki for
information about getting artifacts that are not usually retrieved during sync.
For example, to include unversioned artifacts and configuration settings during
sync:

```sh
fossil sync --unversioned
fossil configuration pull all
fossil rebuild
```

[fossil]: https://fossil-scm.org/
[backup]: https://fossil-scm.org/home/doc/trunk/www/backup.md
