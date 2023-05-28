declare-option -hidden str modeline_git_branch
declare-option -hidden str modeline_pos_percent
declare-option -hidden str modeline_gpg_key_missing

define-command -hidden update-git-branch %{ evaluate-commands %sh{
  branch=$(
    cd "${kak_buffile%/*}" 2>/dev/null && \
    git rev-parse --abbrev-ref --symbolic-full-name HEAD 2>/dev/null
  )

  if test -n "$branch"; then
    printf 'set window modeline_git_branch %%{  %s }' "$branch"
  fi
} }

define-command -hidden update-pos-percent %{ evaluate-commands %sh{
  percent="$((kak_cursor_line * 100 / kak_buf_line_count))%"
  test "$kak_cursor_line" -eq 1 && percent=Top
  test "$percent" = '100%' && percent=End

  printf 'set window modeline_pos_percent %%{%-3s}' "$percent"
} }

define-command -hidden update-gpg-key-missing %{ evaluate-commands %sh{
  if ! gpg --list-keys "$EMAIL" >/dev/null 2>&1; then
    printf 'set window modeline_gpg_key_missing %%{ }'
  fi
} }

hook global WinCreate .* %{
  hook window NormalIdle .* update-gpg-key-missing
  hook window NormalIdle .* update-git-branch
  hook window NormalIdle .* update-pos-percent
  hook window NormalKey [jk] update-pos-percent
}

set-option global modelinefmt '{red}%opt{modeline_gpg_key_missing}{default}'
set-option -add global modelinefmt '{bright-black+i} %val{bufname} '
set-option -add global modelinefmt '{{context_info}} {{mode_info}} '
set-option -add global modelinefmt '{bright-black+r} %opt{filetype}'
set-option -add global modelinefmt '%opt{modeline_git_branch} '
set-option -add global modelinefmt '%val{cursor_line}'
set-option -add global modelinefmt ':%val{cursor_char_column} '
set-option -add global modelinefmt '≣ %opt{modeline_pos_percent} '
