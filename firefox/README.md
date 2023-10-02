# Firefox

Run [Firefox] in a container.

```sh
firefox
```

By default downloads are saved in `~/Downloads`. Use the `MOZ_DOWNLOADS`
environment variable to set an alterntive directory.

If the `MOZ_CLEAN` environment variable is set to a nonempty string, `firefox`
will run a new (ephemeral) instance. Useful for testing/debugging web
development projects in a fresh unaltered profile. Changes are not saved when
the container exits.

```sh
MOZ_CLEAN=1 firefox
```

Here is a suggested alias if this feature proves useful.

```sh
alias cleanfox='MOZ_CLEAN=1 firefox'
```

To use an alternate profile that save changes, set the `MOZ_CONFIG_DIR` and
`MOZ_CACHE_DIR` environment variables. Useful for setting up projects that
require custom configuration that is undesirable in the main profile or require
longer testing periods. Here is an example that just uses the default directory
locations (which is not a useful example but is a good template for your own
aliases/scripts).

```sh
MOZ_CACHE_DIR="$HOME"/.cache/xpod/mozilla \
MOZ_CONFIG_DIR="$HOME"/.config/xpod/mozilla \
MOZ_DOWNLOADS="$HOME"/Downloads \
firefox
```

Also, check out the [configuration documentation](configuration.md) for a basic
_how-to set up a profile_ guide.

[firefox]: https://www.mozilla.org/en-US/firefox/new/
