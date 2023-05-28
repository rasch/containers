declare-user-mode wm

# create new kakoune windows/splits
map global wm c ':tmux-terminal-window kak -c %val{session}<ret>' -docstring 'new window'
map global wm s ':tmux-terminal-vertical kak -c %val{session}<ret>' -docstring 'horizontal bottom split'
map global wm v ':tmux-terminal-horizontal kak -c %val{session}<ret>' -docstring 'vertical right split'

# open *scratch* or *debug* buffers in current window
map global wm n ':edit -scratch "*scratch*"<ret>' -docstring 'scratch buffer'
map global wm u ':buffer "*debug*"<ret>' -docstring 'debug buffer'
