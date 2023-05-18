local lexers = vis.lexers

-- This color theme was designed for use with the Dracula theme. The lexers
-- are not specific enough to implement the Dracula specifications exactly,
-- but this should be close enough.

-- The 8 terminal colors:
  -- black:   #21222c
  -- red:     #ff5555
  -- green:   #50fa7b
  -- yellow:  #f1fa8c
  -- blue:    #bd93f9
  -- magenta: #ff79c6
  -- cyan:    #8be9fd
  -- white:   #f8f8f2

-- extra color definitions that are not one of the default 8
local comment = '#6272a4'
local selection = '#44475a'
local orange = '#ffb86c'

lexers.STYLE_DEFAULT = ''
lexers.STYLE_NOTHING = lexers.STYLE_DEFAULT
lexers.STYLE_CLASS = 'fore:cyan'
lexers.STYLE_COMMENT = 'fore:' .. comment
lexers.STYLE_CONSTANT = 'fore:blue'
lexers.STYLE_DEFINITION = 'fore:blue'
lexers.STYLE_ERROR = 'fore:red'
lexers.STYLE_FUNCTION = 'fore:green'
lexers.STYLE_KEYWORD = 'fore:magenta'
lexers.STYLE_LABEL = 'fore:cyan,italics'
lexers.STYLE_NUMBER = 'fore:blue'
lexers.STYLE_OPERATOR = lexers.STYLE_DEFAULT
lexers.STYLE_REGEX = 'fore:red'
lexers.STYLE_STRING = 'fore:yellow'
lexers.STYLE_PREPROCESSOR = 'fore:magenta'
lexers.STYLE_TAG = 'fore:magenta'
lexers.STYLE_TYPE = 'fore:cyan,italics'
lexers.STYLE_VARIABLE = lexers.STYLE_DEFAULT
lexers.STYLE_WHITESPACE = lexers.STYLE_COMMENT
lexers.STYLE_EMBEDDED = 'fore:' .. orange
lexers.STYLE_IDENTIFIER = lexers.STYLE_DEFAULT

lexers.STYLE_LINENUMBER = lexers.STYLE_COMMENT
lexers.STYLE_LINENUMBER_CURSOR = lexers.STYLE_DEFAULT
lexers.STYLE_CURSOR = 'fore:' .. orange .. ',reverse'
lexers.STYLE_CURSOR_PRIMARY = 'fore:cyan,reverse'
lexers.STYLE_CURSOR_LINE = 'back:black'
lexers.STYLE_COLOR_COLUMN = 'back:black'
lexers.STYLE_SELECTION = 'back:' .. selection
lexers.STYLE_STATUS = 'fore:,back:black'
lexers.STYLE_STATUS_FOCUSED = lexers.STYLE_STATUS
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'bold'
lexers.STYLE_EOF = lexers.STYLE_COMMENT
