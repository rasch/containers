# torbrowser

Run [Tor Browser][1] in a container.

## Known Issues

Audio is not currently supported in this container. The pulseaudio `xpod` option
needs support for non-root users to make this work since torbrowser won't run as
root. This is a current problem with a few of these rootless containers running
applications that enforce non-root use only. The container will also need
additional packages (probably `ffmpeg` and `libpulse0`).

[1]: https://www.torproject.org/download/
