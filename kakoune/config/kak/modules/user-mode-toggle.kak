set-face global ToggleHint StatusLine
set-face global ToggleError Error
set-face global ToggleSearch +uci

define-command -params 1.. toggle-highlighter %{
  try %{
    add-highlighter %arg{@}
  } catch %{
    remove-highlighter %sh{
      if test $(printf "$1" | tail -c 1) = /; then
        printf '%s' "$*" | sed -e 's/ //' -e 's/ /_/g'
      else
        printf "$1"
      fi
    }
  }
}

define-command -docstring %{
  toggle visible whitespaces
} toggle-show-whitespaces %{
  toggle-highlighter window/ show-whitespaces
}

define-command -docstring %{
  toggle line numbers
} toggle-number-lines %{
  remove-highlighter window/number-lines_-relative_-hlcursor
  toggle-highlighter window/ number-lines -hlcursor
}

define-command -docstring %{
  toggle relative line numbers
} toggle-number-lines-relative %{
  remove-highlighter window/number-lines_-hlcursor
  toggle-highlighter window/ number-lines -relative -hlcursor
}

define-command -docstring %{
  toggle soft line wrapping
} toggle-soft-wrap %{
  toggle-highlighter window/ wrap
}

define-command -docstring %{
  toggle right margin column
} toggle-margin-column %{
  toggle-highlighter window/ column %sh{ printf $(($kak_opt_autowrap_column + 1)) } ToggleHint
}

define-command -docstring %{
  toggle search highlighting
} toggle-search-highlight %{
  toggle-highlighter window/t_search_hl dynregex '%reg{/}' 0:ToggleSearch
}

define-command -docstring %{
  toggle long line error highlighting
} toggle-long-line-errors %{
  toggle-highlighter window/t_long_line regex "(?S)^.{%opt(autowrap_column)}(.+)" 1:ToggleError
}

define-command -docstring %{
  toggle cursor line
} toggle-cursor-line %{
  toggle-highlighter window/line line '%val{cursor_line}' ToggleHint
}

define-command -docstring %{
  toggle cursor column
} toggle-cursor-column %{
  toggle-highlighter window/column column '%val{cursor_column}' ToggleHint
}

declare-user-mode toggle
map global toggle w ':toggle-show-whitespaces<ret>' -docstring 'visible whitespace'
map global toggle W ':toggle-soft-wrap<ret>' -docstring 'soft wrap'
map global toggle n ':toggle-number-lines<ret>' -docstring 'line numbers'
map global toggle N ':toggle-number-lines-relative<ret>' -docstring 'relative line numbers'
map global toggle m ':toggle-margin-column<ret>' -docstring 'right margin'
map global toggle e ':toggle-long-line-errors<ret>' -docstring 'long line errors'
map global toggle c ':toggle-cursor-line<ret>' -docstring 'cursor line'
map global toggle C ':toggle-cursor-column<ret>' -docstring 'cursor column'
map global toggle h ':toggle-search-highlight<ret>' -docstring 'highlight search'
