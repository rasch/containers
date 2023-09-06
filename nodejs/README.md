# nodejs

Ironically, `node` is not installed in this container. It contains [fnm] and
[pnpm] for managing [Node.js]® versions and packages respectively. To get
started, use `fnm` to install `node`.

```sh
fnm install --latest
# or
fnm install --lts
```

To use a specific version of `node`, create a file named `.node-version` in the
project's root directory containing the version.

```sh
echo '18.16.1' > .node-version
node -v
# => v18.16.1
```

## Additional Notes

The `.fnm` directory is created at `"$HOME"/.config/xpod/nodejs/fnm` and then
mounted in the appropriate location in the container. The various versions of
Node.js® are saved here (but they mount and run in the container).

The `.pnpm-store` directory is created at `"$HOME"/.config/xpod/nodejs/pnpm` and
mounted in the container for a persistent `pnpm` content-addressable storage.

`npm`/`npx` and `corepack` are included (with Node.js®) for projects that
require them.

[fnm]: https://github.com/Schniz/fnm
[pnpm]: https://pnpm.io/
[Node.js]: https://nodejs.org/
