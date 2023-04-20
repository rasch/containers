define-command -params ..1 -docstring %{
  increment [number]: increment selection by number
} increment %{ execute-keys "a+%sh{expr $1 '|' 1}<esc>|bc<ret>" }

define-command -params ..1 -docstring %{
  decrement [number]: decrement selection by number
} decrement %{ execute-keys "a-%sh{expr $1 '|' 1}<esc>|bc<ret>" }
