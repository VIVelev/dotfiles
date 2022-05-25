vim.g.mapleader = ' '

vim.o.cursorline = true
vim.o.mouse = 'a'
vim.o.splitright = true

-- Performance tweaks
vim.o.lazyredraw = true
vim.o.synmaxcol = 100

-- Disable showmode - i.e. Don't show mode like --INSERT-- in current statusline.
vim.o.showmode = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 600

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.o.signcolumn = 'yes'

vim.o.laststatus = 3

-- Copilot
vim.g.copilot_enabled = false
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ['*'] = false,
    ['c'] = true,
    ['lua'] = true,
    ['rust'] = true,
    ['python'] = true,
}
