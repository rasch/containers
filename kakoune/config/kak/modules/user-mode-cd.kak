declare-user-mode cd

map global cd c ':cd %sh{ printf "%s" "${kak_buffile%/*}" }; pwd<ret>' -docstring 'current buffer directory'
map global cd p ':cd ..; pwd<ret>' -docstring 'parent directory'
map global cd r ':git-root; pwd<ret>' -docstring 'git project root directory'
