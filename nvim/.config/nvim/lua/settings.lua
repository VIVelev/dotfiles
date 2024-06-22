vim.g.mapleader = " "

-- Spelling
vim.o.spell = true

-- Cursor and mouse
vim.o.mouse = "a"
vim.o.mousemodel = "extend"

-- Split to the right
vim.o.splitright = true

-- Performance tweaks
vim.o.lazyredraw = true

-- Disable showmode - i.e. Don"t show mode like --INSERT-- in current status line.
vim.o.showmode = false

-- Having longer update time (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 400

-- Relative line number
vim.o.rnu = true

-- Keep signcolumn so it doesn't disturb
vim.o.signcolumn = "yes"

-- Don't highlight search
vim.o.hlsearch = false

-- Keep cursor away from top/bottom
vim.o.scrolloff = 10

-- Ignore case for / and ?
vim.o.ignorecase = true

-- Show a single status bar
vim.o.laststatus = 3

-- Don't use fancy markdowns
vim.o.conceallevel = 0

vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
