# buildah

[buildah] is a tool that facilitates building OCI container images.

## configuration

This container is configured to use the default storage location for rootless
[podman] containers at `~/.local/share/containers`. This is convenient for
building containers to run locally. Use the environment variable
`XPOD_CONTAINER_DIR` to set a different storage location. This variable can be
set to build throwaway containers for one-time use with `podman --root ...` or
to build an image to push to a registry. When finished the directory can be
deleted with no impact on the default container storage directory.

To mount an additional readonly container store (cache) to pull from, set
the environment variable, `XPOD_CONTAINER_STORE` to an existing container
storage directory (e.g., /var/lib/containers/storage).

## References

- [Best practices for running Buildah in a container][1]
- [Podman manual][2]

[buildah]: https://buildah.io/
[podman]: https://podman.io/
[1]: https://developers.redhat.com/blog/2019/08/14/best-practices-for-running-buildah-in-a-container
[2]: https://docs.podman.io/en/latest/markdown/podman-run.1.html
