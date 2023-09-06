# bun

[Bun] is an all-in-one JavaScript runtime & toolkit.

```sh
bun help
```

This container can run either the included build or the official build from
docker. To use the official build, set the environment variable
`BUN_OFFICIAL_BUILD` to a non-empty value.

```sh
BUN_OFFICIAL_BUILD=1 bun index.ts
```

The environment variable `PORT` needs to be set to bind the container port to
the host when using `Bun.serve` or similar.

```sh
PORT=3000 bun run start
```

The global cache for packages installed with `bun` is stored at
`"$HOME"/.config/xpod/bun` and mounted in the container at the default location.

[Bun]: https://bun.sh
