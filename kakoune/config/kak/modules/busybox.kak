# A wrapper for several busybox/coreutils commands
# that are useful for text and file editing.

# ----------------------------------------
#  pwd
# ----------------------------------------

define-command -docstring %{
  pwd: print the current working directory
} pwd %{ echo -markup "{green}%sh{ pwd }" }

# ----------------------------------------
# chmod
# ----------------------------------------

define-command -params ..1 -docstring %{
  chmod [mode]: change the mode flags of buffile (default: 644)
} chmod %{ echo -markup %sh{
  if ! chmod "${1:-644}" "$kak_buffile"; then
    printf '{Error} Error [chmod]: see *debug* buffer for details '
  fi
} }

complete-command chmod shell-script-candidates %{
  printf '644\n755\n600\n700\n+x\n-x\n+w\n-w\n'
}

# ----------------------------------------
# mkdir
# ----------------------------------------

define-command -params .. -docstring %{
  mkdir [directory]..: create directory(s) or if no directory is given
  create the directory path of the current buffile
} mkdir %{ echo -markup %sh{
  if ! mkdir -p "${@:-$(dirname $kak_buffile)}"; then
    printf '{Error} Error [mkdir]: see *debug* buffer for details '
  fi
} }

complete-command mkdir file

# ----------------------------------------
# rmdir
# ----------------------------------------

define-command -params 1.. -docstring %{
  rmdir <directory>..: delete empty directories
} rmdir %{ echo -markup %sh{
  if ! rmdir -p "$@"; then
    printf '{Error} Error [rmdir]: see *debug* buffer for details '
  fi
} }

complete-command -menu rmdir file

# ----------------------------------------
# find
# ----------------------------------------

define-command -params 1 -docstring %{
  find <file>: find files interactively and open selected file
} find %{ edit %arg{1} }

complete-command -menu find shell-script-candidates %{
  find . -type f -ipath '*'"$1"'*' ! -path '*/.git/*'
  # rg --files --glob "$1" --hidden --iglob '!.git'
}

# ----------------------------------------
# shred
# ----------------------------------------

define-command -params .. -docstring %{
  shred [file]..: securely delete files; if file is not given, shred the
  buffile (note: the files/buffile might still be open in buffers)
} shred %{ echo -markup %sh{
  if ! shred -zu "${@:-$kak_buffile}"; then
    printf '{Error} Error [rmdir]: see *debug* buffer for details '
  fi
} }

complete-command -menu shred file

# ----------------------------------------
# rm
# ----------------------------------------

define-command -params .. -docstring %{
  rm [file]..: delete files/directories; if file is not given, rm the
  buffile (note: the files/buffile might still be open in buffers)
} rm %{ nop %sh{ rm -fr "${@:-$kak_buffile}" } }

complete-command -menu rm file

# ----------------------------------------
# cat
# ----------------------------------------

define-command -params 1.. -docstring %{
  cat <file>..: concatenate files into current buffer at cursor position
} cat %{ execute-keys -draft "|cat %arg{@}<ret>" }

complete-command -menu cat file

alias global read cat
alias global r cat

# ----------------------------------------
# du
# ----------------------------------------

define-command -docstring %{
  du: show disk usage of the current buffile
} du %{ echo -markup %sh{
  data=$(du -hs "$kak_buffile" | cut -f 1)

  if test -z "$data"; then
    printf '{Error} Error [du]: see *debug* buffer for details '
  else
    printf '{green}%s' "$data"
  fi
} }

# ----------------------------------------
# hexdump
# ----------------------------------------

define-command -docstring %{
  hexdump: show hexdump of current selection in info box
} hexdump %{ info -title hexdump %sh{
  printf '%s' "$kak_selection" | hexdump -C
} }

# ----------------------------------------
# xxd
# ----------------------------------------

define-command -params ..1 -docstring %{
  xxd [-r]: convert current selection to hexdump or reverse
} xxd %{ execute-keys -draft "|xxd -g1 %arg{1}<ret>" }

# ----------------------------------------
# md5sum
# ----------------------------------------

define-command -docstring %{
  md5sum: show md5 sum of current selection in info box
} md5sum %{ info -title md5 %sh{
  printf '%s' "$kak_selection" | md5sum | cut -d ' ' -f 1
} }

# ----------------------------------------
# sha1sum
# ----------------------------------------

define-command -docstring %{
  sha1sum: show sha1 sum of current selection in info box
} sha1sum %{ info -title sha1 %sh{
  printf '%s' "$kak_selection" | sha1sum | cut -d ' ' -f 1
} }

# ----------------------------------------
# sha256sum
# ----------------------------------------

define-command -docstring %{
  sha256sum: show sha256 sum of current selection in info box
} sha256sum %{ info -title sha256 %sh{
  printf '%s' "$kak_selection" | sha256sum | cut -d ' ' -f 1
} }

# ----------------------------------------
# sha512sum
# ----------------------------------------

define-command -docstring %{
  sha512sum: show sha512 sum of current selection in info box
} sha512sum %{ info -title sha512 %sh{
  printf '%s' "$kak_selection" | sha512sum | cut -d ' ' -f 1
} }

# ----------------------------------------
# base64
# ----------------------------------------

define-command -params ..1 -docstring %{
  base64 [-d] [-w COL]: base64 encode or decode current selection(s)
  Switches:
      -d      decode
      -w COL  wrap lines at COL (default 76, 0 to disable line wrap)
} base64 %{ execute-keys -draft "|base64 %arg{1}<ret>" }

# ----------------------------------------
# wget
# ----------------------------------------

define-command -params .. -docstring %{
  wget [args]: download files at selection URLs
} wget %{ echo -markup %sh{
  if ! wget -q "$@" $kak_selections; then
    printf '{Error} Error [wget]: see *debug* buffer for details '
  fi
} }

# ----------------------------------------
# ed
# ----------------------------------------

define-command -docstring %{
  ed: open buffile in the ed text editor (good luck!)
} ed %{ tmux-terminal-vertical ed -p '? ' %val{buffile} }

# ----------------------------------------
# vi
# ----------------------------------------

define-command -docstring %{
  vi: open buffile in the vi text editor
} vi %{ tmux-terminal-vertical vi %val{buffile} }

# ----------------------------------------
# ls
# ----------------------------------------

define-command -docstring %{
  ls: show ls long format information for current buffile
} ls %{ echo -markup %sh{
  printf '{green}'
  if ! ls -lh "$kak_buffile"; then
    printf '{Error} Error [ls]: see *debug* buffer for details '
  fi
} }

# ----------------------------------------
# stat
# ----------------------------------------

define-command -docstring %{
  stat: show file status of current buffile
} stat %{ evaluate-commands %sh{
  data=$(stat "$kak_buffile")

  if test -n "$data"; then
    printf 'info -markup "{green}%s"' "$data"
  else
    printf 'echo -markup {Error} Error [stat]: see *debug* buffer for details '
  fi
} }

# ----------------------------------------
# wc
# ----------------------------------------

define-command -params ..1 -docstring %{
  wc [<switches>]: count lines, words and bytes for buffile
  Switches:
    -c  count bytes
    -m  count characters
    -l  count newlines
    -w  count words
    -L  print longest line length
} wc %{ echo -markup %sh{
  printf '{green}'
  if ! wc "$@" "$kak_buffile"; then
    printf '{Error} Error [wc]: see *debug* buffer for details '
  fi
} }

# ----------------------------------------
# fold
# ----------------------------------------

define-command -docstring %{
  fold [width]: wrap selection
} fold %{ execute-keys -draft %sh{
  width=$(expr $kak_count '|' $kak_opt_autowrap_column)
  printf '<a-j>|fold -sw %d<ret>' "$width"
} }

# ----------------------------------------
# mv
# ----------------------------------------

define-command -params 1 -docstring %{
  mv <target>: move/rename the current file/buffile to target
} mv %{ evaluate-commands %sh{
  if ! test -e "$kak_buffile"; then
    printf 'echo -markup {Error} unable to move an unsaved buffer {default}'
    exit 1
  fi

  if test -e "$1"; then
    printf 'echo -markup {Error} the target path already exists {default}'
    exit 1
  fi

  if ! mkdir -p "$(dirname "$1")"; then
    printf 'echo -markup {Error} permission denied in the target directory {default}'
    exit 1
  fi

  if mv "$kak_buffile" "$1"; then
    printf 'delete-buffer! %%{%s}; edit! %%{%s}' "$kak_bufname" "$1"
  else
    printf 'echo -markup {Error} unable to move file {default}'
    exit 1
  fi
} }

complete-command mv file
