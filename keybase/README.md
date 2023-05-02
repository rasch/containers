# keybase

The [official Keybase images][1] would not work for both KBFS and Git in any
configuration that I tried. The only way to get KBFS to work was by running
as the keybase user in the container. Unfortunately, their image changes the
ownership of the mounted volumes which prevents `git` from writing to these
directories. I've built a new image that just includes the `keybase` binaries
(pulled right out of their [official image][2]) and `git`. The container uses a
simplified `entrypoint.sh` script to launch the `keybase` services in the
background and keeps the container running after it is detached. The current
working directory is mounted in the container as the `kbfs` directory.

[1]: https://hub.docker.com/r/keybaseio/client
[2]: https://github.com/keybase/client/tree/master/packaging/linux/docker/standard

## Build and Install

```sh
sh build
cp -i ./bin/keybase ~/.local/bin/
```

## Get Started

```sh
cd /PATH/TO/FILES

# start keybase service and interactive login
keybase login

# or if already logged in just start the service
keybase

# status checks
keybase whoami
keybase status
```

## Stop the Keybase Service

```sh
podman stop keybase-daemon
```

## KBFS

<dl>
  <dt>⚠️ NOTE</dt>
  <dd>
    When running <code>fs</code> commands that deal with local files, the
    current working directory must be the same directory that the keybase server
    was started in and the local files must also be within the current working
    directory. The <code>keybase-daemon</code> container only has host access to
    the directory that it was started in.
  </dd>
</dl>

```sh
# list files for USERNAME in private and public directories
keybase fs ls keybase://private/USERNAME
keybase fs ls keybase://public/USERNAME

# upload a file to USERNAMEs private directory
keybase fs cp PATH/TO/LOCAL/FILE keybase://private/USERNAME/PRIVATE-FILE-NAME

# upload a file to USERNAMEs publc directory
keybase fs cp PATH/TO/LOCAL/FILE keybase://public/USERNAME/PUBLIC-FILE-NAME

# download a file from USERNAMEs public directory
keybase fs cp keybase://public/USERNAME/PUBLIC-FILE .

# delete a file from USERNAMEs private directory
keybase fs rm keybase://private/USERNAME/FILE-TO-DELETE

# see more fs commands
keybase help fs
```

## Keybase Git

<dl>
  <dt>⚠️ NOTE</dt>
  <dd>
    The <code>keybase</code> command has been modified to include the necessary
    subcommands to work with <code>keybase git</code>. They are
    <code>keybase clone</code> to clone a repository from keybase,
    <code>keybase push</code>, <code>keybase pull</code>, and
    <code>keybase fetch</code>.
  </dd>
</dl>

```sh
# list all git repositories in keybase account
keybase git list

# create new repository
keybase git create REPO-NAME

# clone the repository locally (it will be cloned to the directory that the
# keybase service was started in)
keybase clone keybase://private/USERNAME/REPO-NAME
cd REPO-NAME

# make changes locally and commit using `git` as normal
git add .
git commit -m "🎉 Initial commit"

# push the changes back to keybase
keybase push

# delete repository
keybase git delete REPO-NAME
```
