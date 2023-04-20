# Highlighters for all windows with titles that don't begin with an asterisk,
# such as the *scratch* and *debug* buffers.
hook global WinCreate ^[^*]+$ %{
  add-highlighter window/ number-lines -hlcursor
  add-highlighter window/ show-matching
  add-highlighter window/ regex '\h+$' 0:Error
  add-highlighter window/ regex '\b(TODO|FIXME|XXX|NOTE|WARN)\b' 0:Error
}

# Soft wrap lines for all *doc-* buffers except *doc-keymap*.
hook global WinCreate ^\*doc-(?!keymap)\S*$ %{
  add-highlighter window/ wrap -word -indent -width 72
}
