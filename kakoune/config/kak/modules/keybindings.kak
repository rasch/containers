# ----------------------------------------
#        normal mode keybindings
# ----------------------------------------

map -docstring %{
  (un)comment selected lines using line comments
} global normal '#' :comment-line<ret>

map -docstring %{
  wrap selected lines at count or autowrap_column (when no count given)
} global normal ^ :fold<ret>

map -docstring %{
  perform math on selected lines with bc
} global normal = !bc<ret>

map -docstring %{
  perform math on selected lines with bc, replacing selection with result
} global normal <a-=> |bc<ret>

map -docstring %{
  increment selected number by count (default: 1)
} global normal <c-a> :increment<space>%val{count}<ret>

map -docstring %{
  decrement selected number by count (default: 1)
} global normal <c-x> :decrement<space>%val{count}<ret>

hook global BufOpenFifo '\*lint\*' %{
  map global normal <minus> :lint-next-message<ret>
}

hook global BufOpenFifo '\*make\*' %{
  map global normal <minus> :make-next-error<ret>
}

hook global BufOpenFifo '\*grep\*' %{
  map global normal <minus> :grep-next-match<ret>
}

# ----------------------------------------
#         goto mode keybindings
# ----------------------------------------

map global goto n <esc>:buffer-next<ret> -docstring 'next buffer'
map global goto p <esc>:buffer-previous<ret> -docstring 'previous buffer'
map global goto s i -docstring 'first non-blank in line'

# ----------------------------------------
#        insert mode keybindings
# ----------------------------------------

# use <tab>/<s-tab> for insert mode completion; <c-p> doesn't work properly in
# most container runtimes because they use `ctrl-p,ctrl-q` to detach

hook global InsertCompletionShow .* %{
  map window insert <tab> <c-n>
  map window insert <s-tab> <c-p>

  hook -always -once global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
  }
}

# indentation and tab handling; insert spaces instead of tabs

hook global InsertChar <tab> %{ try %{
  execute-keys -draft h@
} }

hook global InsertDelete <space> %{ try %{
  execute-keys -draft h<a-h><a-k>\A\h+\z<ret>i<space><esc><lt>
} }

# use jj as <esc> in insert mode

hook global InsertChar j %{ try %{
  execute-keys -draft hH <a-k>jj<ret> d
  execute-keys <esc>
} }

# ----------------------------------------
#           object definitions
# ----------------------------------------

map -docstring %{
  xml tag objet
} global object t c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>

# ----------------------------------------
#         user mode keybindings
# ----------------------------------------

map global user f :find<space> -docstring 'open file picker'
map global user b :buffer<space> -docstring 'open buffer picker'

# clipboard

map -docstring %{
  join and yank selections to clipboard
} global user y ':nop %sh{printf "%s" "$kak_selections" | xsel --input --clipboard}<ret>'

map -docstring %{
  yank main selection to clipboard
} global user Y '<a-|>xsel --input --clipboard<ret>'

map -docstring %{
  paste clipboard after selections
} global user p '<a-!>xsel --output --clipboard<ret>'

map -docstring %{
  paste clipboard before selections
} global user P '!xsel --output --clipboard<ret>'

map -docstring %{
  replace selections by clipboard content
} global user R '|xsel --output --clipboard<ret>'

# user modes

map global user c :enter-user-mode<space>cd<ret> -docstring cd
map global user i :enter-user-mode<space>info<ret> -docstring info
map global user t :enter-user-mode<space>toggle<ret> -docstring toggle
map global user w :enter-user-mode<space>wm<ret> -docstring window

# alignment

map global user [ :align-left<ret> -docstring 'left align line'
map global user ] :align-right<ret> -docstring 'right align line'
map global user = :align-center<ret> -docstring 'center line'

# misc

map global user a *%s<ret> -docstring 'select all'
map global user m :preview-markdown<ret> -docstring 'preview markdown'
map global user x :chmod<ret> -docstring 'change file mode'
map global user / /(?i) -docstring 'case-insensitive search'
map global user B '|banner "$kak_selection"<ret>' -docstring 'bruce banner'
