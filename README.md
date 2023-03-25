# containers

a collection of POSIX shell scripts to build and run OCI images

## building the images

```sh
cd <application>
buildah unshare ./build
```

There are a few dependencies for building the images. The scripts are
written using POSIX standards for (hopefully) better portability. Most
commands are run in the build container using `buildah` for guaranteed
availability. The rest of the commands, `trap`, `test`, `printf`, and
`exit`, should be available on any POSIX-ish system.

The containers are generally configured for my system and preferences.
Feel free to edit the files in the project's `config` directory before
building. Instead of editing the included config files, it may be easier
to maintain your own files and `--volume` mount them in their proper
locations in the container.

## running the images

Most of the images require access to parts of the host OS, such as
audio, for proper functionality. Included in this repository is a script
named `xpod` to make it easier to grant these privileges to each image.
Install the `xpod` script by placing it somewhere in the PATH:

```sh
cp xpod ~/.local/bin/
```

Check out the help menu to see the available options:

```sh
xpod -h
```

Each application/image has a `bin` directory which contains one or more
scripts that can be copied into the PATH. This allows for running the
application containers as if they were installed (well... almost).

## examples

Serve a static web site from the current directory.

```sh
xpod -B -- --publish 5150:5150 alpine:edge /bin/sh -l
apk add --no-cache darkhttpd
darkhttp . --port 5150
```

Read a PDF file with `mupdf`...

```sh
cd mupdf
buildah unshare ./build
cd <path/to/pdf>
xpod -Bdx -- mupdf <my_document.pdf>
```

...or

```sh
cd mupdf
buildah unshare ./build
cp bin/mupdf ~/.local/bin/
cd <path/to/pdf>
mupdf <my_document.pdf>
```

## some final notes

I've been running a minimal Linux OS, containing only the required
packages to support these images since _2020-06-16_. There have not been
any significant problems, but there are some inconveniences:

- The tilde (~) and parent (..) directory shortcuts don't work when
  using `xpod`'s `-B` flag. All paths given must be within the current
  working directory. The current directory is mounted in the container
  and the container doesn't have access to the parent directory.

- It can be difficult to connect applications, for example: clicking a
  link in `mupdf` running in a container won't open the link in the
  BROWSER because it looks for the browser in its own container rather
  than an external container. It is easy to connect through servers or
  through the clipboard, and I've found this to cover most of my use
  cases.
