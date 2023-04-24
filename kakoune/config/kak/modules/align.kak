define-command -docstring %{
  align-center: add left padding to current line to center within the
  given count (default: 80)
} align-center %{
  execute-keys x_\"zy<a-\;>Ghc
  execute-keys %sh{ printf '%*s' $((($(expr $kak_count '|' 80) - ${#kak_reg_z}) / 2)) }
  execute-keys <esc>\"zP
}

define-command -docstring %{
  align-right: add left padding to current line to right align within
  the given count (default: 80)
} align-right %{
  execute-keys x_\"zy<a-\;>Ghc
  execute-keys %sh{ printf '%*s' $(($(expr $kak_count '|' 80) - ${#kak_reg_z})) }
  execute-keys <esc>\"zP
}

define-command -docstring %{
  align-left: remove left padding from current line
} align-left %{
  execute-keys x_\"zy<a-\;>Ghd\"zP
}
