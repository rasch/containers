define-command -params ..1 -docstring %{
  count [<switches>]: show total word count for all selections
  or an alternate count specified by switch
  Switches:
      -bytes    show byte count
      -chars    show character count
      -lines    show number of newlines
      -buffers  show number of buffers (excludes *debug*)
} count %{ echo %sh{
  if test "$1" = '-buffers'; then
    printf '﬘ %s' $(($(echo $kak_buflist | wc -w) - 1))
    return
  fi

  test "$1" = '-bytes' && wc_arg=c type=byte
  test "$1" = '-chars' && wc_arg=m type=character
  test "$1" = '-lines' && wc_arg=l type=line

  eval set -- "$kak_quoted_selections"

  while test $# -gt 0; do
    total=$((total + $(printf '%s' "$1" | wc -${wc_arg:-w})))
    shift
  done

  test "$total" -ne 1 && plural=true

  printf '%s %s%s' "$total" "${type:-word}" "${plural:+s}"
} }
