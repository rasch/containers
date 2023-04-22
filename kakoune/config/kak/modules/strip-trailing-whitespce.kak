define-command -docstring %{
  strip-trailing-whitespace: remove trailing blank characters from each
  line in the current buffer (usually not needed since most languages in
  kakoune have hooks that remove trailing whitespace)
} strip-trailing-whitespace %{ try %{ execute-keys -draft \%s\h+$<ret>d } }
