# rtorrent

## Configuration

If the environment variable `TORRENT_DIR` is set to an existing directory, it
will be used as the torrent directory. Otherwise, the current working directory
is set as the torrent directory. `rtorrent` will create four subdirectories in
the torrent directory if not already created:

- `.session` - session info, for starting where it left off
- `download` - the downloaded files
- `log` - rtorrent logs
- `watch` - the directory to watch for new torrent files, either in the
  subdirectory `load` or `start`.
