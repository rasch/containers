# isync

A Linux container for managing and sending email.

- [mbsync]: sync between IMAP (remote) <---> Maildir (local)
- [notmuch]: mail search and tagging
- [mblaze]: a MUA composed of UNIX-like utilities
- [send]: a little frontend script for `busybox sendmail`

## Getting Started

It is only necessary to setup the accounts that will be used. If additional
IMAPS providers are needed, please submit an issue (or even better, a pull
request).

### Set Environment Variables

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

### Create Sync Directories

Create directories for syncing email locally. They will contain the Maildir
directories created by `mbsync`.

```sh
mkdir -p "$MAILDIR"/gmail
mkdir -p "$MAILDIR"/riseup
mkdir -p "$MAILDIR"/zoho
```

### Create Local Maildirs

Create local Maildir directories. I use `local/Inbox` as my email archive and
move email files there using `mrefile` (mblaze) and/or (`mail`) s-nail. The
`local/Sent` directory keeps an archive of my sent mail. Email composed and/or
sent using mblaze (`mcom` or `mrep`) or s-nail (`mail`) gets saved here.

```sh
mkdir -p "$MAILDIR"/local
mmkdir "$MAILDIR"/local/Inbox "$MAILDIR"/local/Sent
```

### Setup Authentication File

Create an encrypted `.netrc` file at `"$MAILDIR"/.netrc.asc` for storing email
credentials (application passwords). For example:

```sh
cat <<'EOF' >> "$MAILDIR"/.netrc
machine *.gmail.com login USERNAME@DOMAIN password PASSWORD
machine *.riseup.net login USERNAME password PASSWORD
machine *.zoho.com login USERNAME@DOMAIN password PASSWORD
EOF

gpg -ae "$MAILDIR"/.netrc
shred -zu "$MAILDIR"/.netrc
```

### S-nail History File

Create the history file for `s-nail`. This step is optional, but there will be
a missing file error when running `mail` for the first time.

```sh
touch "$MAILDIR"/.s-nailhist
```

## Sync Email (mbsync/notmuch)

Sync IMAP accounts to local directory from remote(s).

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

Instead of running `mbsync` to fetch email, a `notmuch new` pre-hook can be
used. This enables fetching remote mail and updating the search index with a
single command, `notmuch new` 🎉

```sh
mkdir -p "$MAILDIR"/.notmuch/hooks
echo 'mbsync --all' >> "$MAILDIR"/.notmuch/hooks/pre-new
chmod +x "$MAILDIR"/.notmuch/hooks/pre-new
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
is more complex than what will be covered here, but a few examples are shown
below.

### mblaze Configuration

Before using `mblaze`, a configuration file must be created (sorry, I haven't
found a way to use environment variables here yet). Copy the example below to
`"$MAILDIR"/.mblaze/profile` and edit the values. Also be sure to create the
Outbox Maildir before composing mail, `mmkdir "$MAILDIR/Sent"`, for example.

```txt
Local-Mailbox: Quinn Jones <quinn@example.com>
Alternate-Mailboxes: Quinn Joines <qjones@example.com>, Quinn Jones <qj@example.com>
FQDN: example.com
Outbox: /root/mail/local/Sent
Scan-Format: %c%u%r %-3n %10d  %17f  %t %2i%s
Sendmail: send
Sendmail-Args: gmail
```

### mblaze Examples and Usage

Create a sequence file that contains all mail from the `gmail/Inbox` Maildir
sorted by reverse date (newest first) and display message summaries in pager.

```sh
mlist gmail/Inbox | msort -dr | mseq -S | mscan
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

## Interactive Usage (s-nail)

[S-nail] is included for interactive (or scripted) mail management. You will
want (need) to read the user manual (`man mail`) to get started.

```sh
# start with local/Inbox
mail

# connect to remote account Inbox using IMAP
mail -A gmail
mail -A riseup
mail -A zoho

# start with local gmail/Inbox
mail -f gmail/Inbox
```

## Directory/File Tree

If everything above is configured, then the file tree will look something like
the diagram below. This is just a brief overview of the files in the mail
directory.

```txt
     🗁 $MAILDIR
 (1) ├── 🗁 .mblaze
 (2) │  ├── 🗏 profile
 (3) │  └── 🗏 signature
     ├── 🗁 .notmuch
     │  ├── 🗁 hooks
 (4) │  │  ├── 🗏 post-new
 (5) │  │  └── 🗏 pre-new
 (6) │  └── 🗁 xapian
 (7) ├── 🗏 .netrc.asc
 (8) ├── 🗏 .s-nailhist
     ├── 🗁 local
 (9) │  ├── 🗁 Inbox
(10) │  └── 🗁 Sent
(11) ├── 🗁 gmail
(12) ├── 🗁 riseup
(13) └── 🗁 zoho
```

1. The `mblaze` configuration directory. Also stores `seq` and `cur` files for
   tracking the current sequence and selected mail.
2. The [configuration file](#mblaze-configuration) for `mblaze`.
3. An (optional) mail signature used by `mcom` and `mrep`.
4. An (optional) executable script that runs after `notmuch new`. Useful for
   processing mail (tagging, sorting, etc).
5. An (optional) executable script that runs before `notmuch new`. Useful for
   fetching mail with `mbsync` prior to indexing.
6. The `.notmuch/xapian` directory is the search and tag index. If you've spent
   some time tagging mail with `notmuch` then this directory is important to
   backup.
7. [Authentication details](#setup-authentication-file) for `mail`, `send` and
   `mbsync`.
8. History file for `mail` (s-nail).
9. Local Maildir for saving/archiving mail.
10. Local Maildir for saving/archiving sent mail.
11. An (optional) local copy of Gmail mail (saved as Maildirs by `mbsync`).
12. An (optional) local copy of Riseup mail (saved as Maildirs by `mbsync`).
13. An (optional) local copy of Zoho mail (saved as Maildirs by `mbsync`).

[mbsync]: https://isync.sourceforge.io/
[notmuch]: https://notmuchmail.org/
[mblaze]: https://github.com/leahneukirchen/mblaze
[send]: https://git.sr.ht/~rasch/containers/tree/main/item/isync/scripts/send
[s-nail]: https://www.sdaoden.eu/code.html
