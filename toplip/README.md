# toplip

[toplip] is an encryption/decrytion utility.

The `podman run` command with the `--tty` flag breaks the I/O for `toplip`
because it combines STDOUT and STDERR, but without the flag, the password is
visible. The script included with this `toplip` container displays the input at
the password prompt because there is no tty attached. If the password must be
hidden, use the `toplip-repl` script to run an interactive shell prompt instead.

[toplip]: https://2ton.com.au/toplip/
