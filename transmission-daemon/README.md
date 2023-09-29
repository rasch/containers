# transmission-daemon

Run `transmission-daemon` in a detached container.

## Configuration

The configuration files are stored in
`"$HOME"/.config/xpod/transmission-daemon`.

Use the environment variable, `TORRENT_DIR`, to set the download directory. If
`TORRENT_DIR` is not set, then files are saved in `$(pwd)/download`.

The `transmission-daemon --allowed` option is set to the value of the
environment variable, `XPOD_INET`, and falls back to `10.0.2.100`. This is a
solution for the `rootlesskit` port forwarding backend for `slirp4netns` not
preserving the source IP address.

The web interface is available at `<Local ip address>:9091`. For example:
`192.168.1.101:9091` or use `transmission-remote 192.168.1.101 -l` or
`alias transmission="transmission-remote 192.168.1.101"`.
