require('vis')

vis.events.subscribe(vis.events.INIT, function()
  -- global configuration options
  vis:command('set escdelay 10')
  vis:command('set theme custom')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  -- per window configuration options
  vis:command('set number')

  vis:command('set tabwidth 2')
  vis:command('set autoindent')
  vis:command('set expandtab')

  vis:command('set colorcolumn 80')
end)

-- toggle visible whitespace -------------------------------------------

vis:map(vis.modes.NORMAL, ' tw', function()
  vis:command('set show-newlines!')
  vis:command('set show-spaces!')
  vis:command('set show-tabs!')
end)

-- strip trailing whitespace -------------------------------------------

vis:command_register('strip-trailing-whitespace',
  function(argv, force, win, selection, range)
    local lines = win.file.lines
    local line = selection.line
    local col = selection.col

    for index=1, #lines do
      lines[index] = lines[index]:gsub('%s+$', '')
    end

    win.selection:to(line, col)

    return true
  end, 'Strip trailing whitespace')

vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file, path)
  vis:command('strip-trailing-whitespace')
end)
