# code
set-face global value blue
set-face global type magenta
set-face global variable cyan
set-face global module yellow
set-face global function green
set-face global string yellow
set-face global keyword magenta
set-face global operator magenta
set-face global attribute magenta
set-face global comment bright-black
set-face global documentation comment
set-face global meta magenta
set-face global builtin cyan+i

# markup
set-face global title blue+b
set-face global header blue+b
set-face global mono green
set-face global block yellow
set-face global link cyan
set-face global bullet cyan
set-face global list default

# builtin faces
set-face global Default default,default
set-face global PrimarySelection bright-magenta+rF
set-face global SecondarySelection bright-blue+rF
set-face global PrimaryCursor magenta+rF
set-face global SecondaryCursor blue+rF
set-face global PrimaryCursorEol +rF
set-face global SecondaryCursorEol +rF
set-face global MenuForeground bright-black,yellow+rb
set-face global MenuBackground default,black
set-face global MenuInfo comment
set-face global Information Default
set-face global Error default,red+bF
set-face global DiagnosticError red
set-face global DiagnosticWarning cyan
set-face global StatusLine default,black
set-face global StatusLineMode green
set-face global StatusLineInfo blue
set-face global StatusLineValue green
set-face global StatusCursor default+r
set-face global Prompt green
set-face global BufferPadding comment

# builtin highlighter faces
set-face global LineNumbers comment
set-face global LineNumberCursor default
set-face global LineNumbersWrapped +d@comment
set-face global MatchingChar green+uF
set-face global Whitespace comment
set-face global WrapMarker comment

# italicize HTML/JSX attributes
hook global WinCreate .*\.(html|jsx)$ %{
  set-face buffer attribute +i@attribute
  set-face buffer keyword +a@keyword
}
