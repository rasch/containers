declare-user-mode info

map global info . ':info %sh{printf "U+%04x" $kak_cursor_char_value}<ret>' -docstring 'character codepoint'
map global info c ':info -markup %sh{cal | sed -e "s/\b$(date +%e)\b/{MenuForeground}&{default}/"}<ret>' -docstring 'calendar'
map global info s ':info -title session "%val{client}: %val{session}"<ret>' -docstring 'client / session'
map global info t ':info -markup "{green}%sh{banner $(date +%R)}"<ret>' -docstring 'time'
map global info x ':show-color<ret>' -docstring 'show selected hex color in statusline'
