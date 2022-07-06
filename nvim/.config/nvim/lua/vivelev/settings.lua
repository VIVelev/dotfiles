vim.g.mapleader = ' '

-- Cursor and mouse
vim.o.cursorline = true
vim.o.mouse = 'a'

-- Split to the right
vim.o.splitright = true

-- Performance tweaks
vim.o.lazyredraw = true
vim.o.synmaxcol = 100

-- Disable showmode - i.e. Don't show mode like --INSERT-- in current status line.
vim.o.showmode = false

-- Having longer update time (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 600

-- Always show the sign column, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.o.signcolumn = 'yes'

-- A single status bar
vim.o.laststatus = 3
