vim.o.shell = '/usr/local/bin/bash'
vim.cmd('set termguicolors')
vim.cmd('syntax on')
vim.o.guifont = 'FiraMono Nerd Font:h12'

vim.cmd('set expandtab')      -- enter spaces when tab is pressed
vim.cmd('set textwidth=120')  -- break lines when line length increases
vim.cmd('set tabstop=4')      -- use 4 spaces to represent tab
vim.cmd('set softtabstop=4')
vim.cmd('set shiftwidth=4')   -- number of spaces to use for auto indent
vim.cmd('set autoindent')     -- copy indent from current line when starting a new line
vim.cmd('set smartindent')

-- make backspaces more powerfull
vim.o.backspace = 'indent,eol,start'

-- Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
vim.o.listchars = 'tab:>-,trail:-,nbsp:_'
vim.cmd('set list')

vim.cmd('set rnu')
vim.cmd('set cursorline')
vim.o.mouse = 'a'
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set splitright')

-- Performance tweaks
vim.cmd('set lazyredraw')
vim.cmd('set synmaxcol=100')

-- Disable showmode - i.e. Don't show mode like --INSERT-- in current statusline.
vim.cmd('set noshowmode')

-- Give more space for displaying messages.
vim.cmd('set cmdheight=2')

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.cmd('set updatetime=1000')

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd('set signcolumn=yes')
