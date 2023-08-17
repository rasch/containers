# isync

## Getting Started

It is only necessary to setup the accounts that will be used. If additional
IMAPS providers are needed, please submit an issue (or even better, a pull
request).

Add environment variables to `.profile`, `.bash_profile` or somewhere else
depending on the shell. Fallback options are displayed as comments after each
variable.

```sh
export NAME='Quinn Jones' # $GIT_AUTHOR_NAME -> $GIT_COMMITTER_NAME -> $(whoami)
export EMAIL=quinn@example.com
export GMAIL_EMAIL=example@gmail.com # $EMAIL
export RISEUP_EMAIL=example@riseup.net # $EMAIL
export ZOHO_EMAIL=quinn@example.com # $EMAIL
export GPG_DIR="$HOME"/.gnupg # $GNUPGHOME -> $HOME/.config/xpod/gnupg
export MAILDIR="$HOME"/mail # $HOME/.config/xpod/mail
```

Create directories for syncing email locally.

```sh
mkdir -p "$MAILDIR"/gmail
mkdir -p "$MAILDIR"/riseup
mkdir -p "$MAILDIR"/zoho
```

Create encrypted files for storing email credentials such as application
passwords. Each password should be placed in its own file with no additional
text. The file path for each account's credentials should be
`$MAILDIR/.<account>.asc` For example, to set up a gmail account:

```sh
vi "$MAILDIR"/.gmail
gpg --armor --encrypt "$MAILDIR"/.gmail
shred -zu "$MAILDIR"/.gmail
```

## Sync Email (mbsync/notmuch)

Sync IMAP accounts in local directory from remote(s).

```sh
mbsync gmail
mbsync zoho
mbsync riseup
# --- or ---
mbsync --all
```

Update `notmuch` database after fetching mail from remote(s).

```sh
notmuch new
```

Sync with remote(s) after making changes locally.

```sh
mbsync --push gmail
mbsync --push zoho
mbsync --push riseup
# --- or ---
mbsync --push --all
```

## Send Email (sendmail)

Run `send` with no arguments for detailed usage instructions. The `send` script
that is included in this container uses the `busybox sendmail` command behind
the scenes. Example usage:

```sh
cat draft.eml
```

```txt
To: recipient@example.com
From: Quinn Jones <quinn@example.com>
Subject: Hello, world!

Body text.
```

```sh
send zoho draft.eml
```
