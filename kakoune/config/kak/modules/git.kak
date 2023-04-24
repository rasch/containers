define-command -params 1 -docstring %{
  git-edit: select file to edit from git project
} git-edit %{ edit %arg{1} }

complete-command git-edit shell-script-candidates %{ git ls-files 2>/dev/null }

define-command -docstring %{
  cd to git project root directory
} git-root %{
  try %{
    cd %sh{ printf '%s\n' "${kak_buffile%/*}"}
    cd %sh{ git rev-parse --show-toplevel 2>/dev/null }
  } catch %{
    echo -markup '{Error} The current directory is not a Git repository '
  }
}

# highlight long Git commit lines
hook -group git-commit-highlight global WinSetOption filetype=git-(commit|rebase) %{
  add-highlighter window/git-commit-highlight \
    regex "^(?:\A[^#\s][^\n]{49}|[^#\s][^\n]{71})([^\n]+)" 1:Error
}
