# skopeo

[skopeo] is a command line utility for working with remote image registries.

- copy image from one location to another (including registry to registry)
- delete image from registry
- inspect information about image in a registry (or local)
- list-tags from an image registry
- sign/verify images

## containers-storage (local container images)

This container is configured to use the default storage location for rootless
[podman] containers at `~/.local/share/containers`. Use the environment variable
`XPOD_CONTAINER_DIR` to set a different storage location.

## login

Login credentials are stored at `~/.config/xpod/skopeo/auth.json`.

## --privileged

Unfortunately, working with local images requires the `podman --privileged`
flag.

[podman]: https://podman.io/
[skopeo]: https://github.com/containers/skopeo
