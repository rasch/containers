# enable editorconfig
hook global BufNewFile .* %{ editorconfig-load }
hook global BufOpenFile .* %{ editorconfig-load }
