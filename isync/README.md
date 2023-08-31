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

## Read and Manage Email (mblaze)

This is probably a bit different for most people, but `mblaze` is a set of UNIX
like utilities for managing Maildir folders locally. Learning to use these tools
is more complex than what will be covered here, but here are a few examples:

Create a sequence file that contains all mail from the ./gmail/Inbox Maildir
sorted by reverse date (newest first) and display message summaries in pager.

```sh
mlist ./gmail/Inbox | msort -dr | mseq -S | mscan
```

Show message number 27 (from `mscan`) in pager.

```sh
mshow 27
mless 27  # use :n and :p to go to next and previous messages
```

Compose and send an email or reply to a message.

```sh
mcom someone@example.com
mrep 27
```

Before using `mblaze`, a configuration file must be created (sorry, I haven't
found a way to use environment variables here yet). Copy the example below to
`"$MAILDIR"/.mblaze/profile` and edit the values. Also be sure to create the
outbox Maildir before composing mail, `mmkdir "$MAILDIR/outbox"`, for example.

```txt
Local-Mailbox: Quinn Jones <quinn@example.com>
Alternate-Mailboxes: Quinn Joines <qjones@example.com>, Quinn Jones <qj@example.com>
FQDN: example.com
Outbox: /root/mail/outbox
Scan-Format: %c%u%r %-3n %10d  %17f  %t %2i%s
Sendmail: send
Sendmail-Args: gmail
```

A script, `mblaze`, is included that launches an interactive shell with the
current working directory set to the mail directory. This is useful when
processing a lot of mail (because it's a bit faster and caches the gpg
password).

Check out the man page, `man mblaze`, to see the full list of available tools
and their options.

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
