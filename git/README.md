# Git

This is my personal [Git] configuration wrapped up in a container. It includes
several `git` scripts and aliases in addition to configuration files for `gpg`
and `ssh`.

## What's Included

Scripts are included that expose the container's binaries for `git`, `gpg`,
`gpgtar`, `ssh`, `scp`, `dbclient`, `rsync` and `igit`. These programs are all
included in the image because they rely on each other for much of their
functionality.

- `git`: This is the main purpose of the image. Git uses external applications
  for accomplishing many important tasks, so _a few_ are also included.
  Unfortunately, this `git` command must be run from the root of a Git
  repository because the hosts current directory is mounted as the working
  directoy in the container and the `.git` directory must be available. Each
  `git` command is run in a new container. This means that the `gpg-agent`
  doesn't stay running and the password for `gpg` authentication may need to be
  entered more often than desired. A script, `igit` is included to run in an
  interactive shell. This script can be used when several signed commits must be
  made or to work in subdirectories of the repository.

- `gpg`: Included for signing/verifying `git` commits/tags, but can be used as a
  standalone application. Also `gpg-agent` is used for `ssh` authentication with
  PGP Authentication subkeys. `gpgtar` is included for encrypting/signing files
  into an archive.

- `ssh/dbclient`: `dropbear-dbclient` is included for git transfers over ssh,
  but can also be used as a standalone application. `dropbear-ssh` is included
  for compatibility with applications that call `ssh` directly. The `scp`
  command is also available from the `dropbear-scp` package.

- `rsync`: This is included because of its dependency on `ssh` for file
  transfers and `gpg-agent` for `ssh` authentication.

## Configuration

In order to use this `git` container, some environment variables need to be set.
This is a much easier method to share this image without hardcoding my name and
email in `.gitconfig`. For example in `~/.profile` or `~/.bash_profile`:

```sh
export EMAIL='address@example.com'
export GIT_AUTHOR_NAME='Your Name'
export GIT_COMMITTER_NAME='Your Name'
```

## Git Aliases and Scripts

The aliases from the [GitAlias/gitalias] repository are included in addition to
a few of my own. Run `git aliases` to see them all.

A few scripts have also been included:

- `git emoji`: Search/Display emoji and descriptions from [gitmoji] for use in
  commit messages. Usage: `git emoji [regexp]`. If no regexp is given, all emoji
  are displayed.

- `git find-missing-attr`: Generate a .gitattributes file in the repository
  root. Run `git find-missing-attr -h` for usage.

- `git hooks`: Sets up git hooks as symlinks that call this script. When this
  script is run directly, it sets up the symlinks. When called from a symlink,
  the respective hooks are run. Hooks are ran if placed in one of the following:

  - ~/.config/git/hooks/plugins/\*/<hook>
  - .git/hooks/\*/<hook>
  - .githooks/\*/<hook>

  This `git hooks` script basically enables hooks to be created as plugins and
  placed directly in one of the hook directories listed above (the asterisk
  should be replaced with the name of the plugin and \<hook\> is any of the
  supported git hooks, such as "pre-commit"). The \<hook\> must be an executable
  script to run. With this setup, git hook plugins can be installed globally for
  all repositories on the local machine, or locally for a single repository, or
  in the repository in a `.githooks` directory.

- `git init-lfs`: When using the `git hooks` script above (which has been done
  in this container) setting up a repository for `git lfs` requires special
  handling. This script makes it easy though.

- `git ps1`: A basic `git` prompt for embedding in the shell's `PS1` environment
  variable. For example: `PS1="...\$(_ps1_prompt)..."`.

- `git pubkey`: Add public GPG key to Git repository as a raw `git` object. Run
  `git pubkey -h` for usage.

## Git Email

Git in this image is not configured for use with email. It requires the Alpine
Linux package `git-email`, which has a Perl dependency that makes this container
a bit larger than I like. There is a good tutorial for using `git` to
collaborate over email, [email + git = <3][email+git].

## Git LFS

The `git-lfs` package is not included in this image. While `git-lfs` provides
useful functionality, it is not supported everywhere and the places where it is
supported have limitations (costs). In my personal projects, I've been using an
orphan branch named `assets` or `media` for keeping binary objects that are not
mission critical to the application. The `git-lfs` package adds 11 MB (about
30%) to the container size. The increased size isn't worth it for something that
is rarely used. If someone reads this and needs `git-lfs` support, just file an
issue!

## Additional Git Resources

- [Tips]
- [Workflow]
- [Interactive Cheatsheet]
- [Common Problems]

[Git]: https://git-scm.com/
[GitAlias/gitalias]: https://github.com/GitAlias/gitalias.git
[gitmoji]: https://gitmoji.dev/
[email+git]: https://git-send-email.io/
[Tips]: https://github.com/git-tips/tips
[Workflow]: https://gist.github.com/jbenet/ee6c9ac48068889b0912
[Interactive Cheatsheet]: https://ndpsoftware.com/git-cheatsheet.html
[Common Problems]:
  https://41j.com/blog/2015/02/common-git-screwupsquestions-solutions/
