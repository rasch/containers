define-command -params 1..2 -docstring %{
  plugin <repository> [file]: clone git repository and source file;
  use a shell pattern to source multiple files (default: "*.kak")
  Examples:
      plugin dracula/kakoune
      plugin alexherbo2/auto-pairs.kak
      plugin anhsirk0/kakoune-themes pastel.kak
      plugin https://gitlab.com/Screwtapello/kakoune-inc-dec
} plugin %{ evaluate-commands %sh{
  directory="${1#*//*/}"
  pattern="$2"
  plugin="$kak_config/plugins/$directory"

  if test "$1" = "$directory"; then
    set -- "https://github.com/$directory"
  fi

  if ! test -d "$plugin"; then
    GIT_TERMINAL_PROMPT=0 git clone --quiet --depth 1 "$1" "$plugin" 2>/dev/null
  fi

  if test -d "$plugin"; then
    find -L "$plugin" -type f -name "${pattern:-*.kak}" \
      -exec printf 'source %s\n' '{}' ';'
  else
    printf "echo -debug Plugin Not Found: %s" "$1"
  fi
} }
