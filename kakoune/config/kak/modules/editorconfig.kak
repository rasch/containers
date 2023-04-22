# enable editorconfig
hook global WinCreate ^[^*]+$ %{ editorconfig-load }
