# aspell

Spellcheck with [GNU Aspell][1].

Only the `aspell-en` dictionary is included in this container (for now). There
is no configuration needed unless you have a [personal word list and/or
replacement list][1] or would like to save one.

```sh
mkdir -p "$HOME"/.config/xpod/aspell

# if the files don't exist
touch "$HOME"/.config/xpod/aspell/dict_en_US
touch "$HOME"/.config/xpod/aspell/repl_en_US

# or `mv` your own files to these paths!
```

These files (if they exist) are mounted in their proper locations in the
container.

[1]: http://aspell.net/
[2]:
  http://aspell.net/man-html/Format-of-the-Personal-and-Replacement-Dictionaries.html
