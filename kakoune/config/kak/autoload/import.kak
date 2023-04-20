define-command -params 1 -docstring %{
  import <file>: try to source kak file from given path
} import %{ try %{ source "%arg{1}" } }
