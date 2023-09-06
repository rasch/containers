# hunspell

Spellcheck with [Hunspell][1].

Only the `hunspell-en-us` dictionary is included in this container (for now).
There is no configuration needed unless you have a personal word list or would
like to save one.

```sh
mkdir -p "$HOME"/.config/xpod/hunspell

# if the file doesn't exist
touch "$HOME"/.config/xpod/hunspell/dict_en_US

# or `mv` your own file to this path!
```

This file (if it exists) is mounted in the proper locations in the container.

[1]: https://hunspell.github.io/
