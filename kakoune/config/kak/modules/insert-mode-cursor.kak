# change cursor color in insert mode

hook global ModeChange .*:.*:insert %{
  set-face window PrimaryCursor green+rfg
  set-face window PrimaryCursorEol green+rfg
}

hook global ModeChange .*:insert:.* %{ try %{
  unset-face window PrimaryCursor
  unset-face window PrimaryCursorEol
} }
