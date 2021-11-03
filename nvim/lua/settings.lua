vim.o.shell = '/usr/local/bin/bash'
vim.o.termguicolors = true
vim.cmd('syntax on')
vim.o.guifont = 'FiraMono Nerd Font:h12'

vim.o.expandtab   = true  -- enter spaces when tab is pressed
vim.o.textwidth   = 120   -- break lines when line length increases
vim.o.tabstop     = 4     -- use 4 spaces to represent tab
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4     -- number of spaces to use for auto indent
vim.o.autoindent  = true  -- copy indent from current line when starting a new line
vim.o.smartindent = true

-- make backspaces more powerfull
vim.o.backspace = 'indent,eol,start'

-- -- Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
-- vim.o.listchars = 'tab:>-,trail:-,nbsp:_'
-- vim.cmd('set list')

-- Don't expand tab for:
vim.cmd('autocmd FileType go setlocal noexpandtab')
-- vim.cmd('autocmd FileType go setlocal nolist')

vim.o.rnu = false
vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.splitright = true

-- Performance tweaks
vim.o.lazyredraw = true
vim.o.synmaxcol = 100

-- Disable showmode - i.e. Don't show mode like --INSERT-- in current statusline.
vim.o.showmode = false

-- Give more space for displaying messages.
vim.o.cmdheight = 2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 250

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.o.signcolumn = 'yes'

-- Copy once, paste multiple times.
vim.cmd('xnoremap p pgvy')

-- Copilot
vim.cmd([[
    let g:copilot_filetypes = {
      \ '*': v:false,
      \ 'go': v:true,
      \ 'rust': v:true,
      \ 'python': v:true,
      \ 'lua': v:true,
  \ }
]])

vim.g.copilot_no_tab_map = true
