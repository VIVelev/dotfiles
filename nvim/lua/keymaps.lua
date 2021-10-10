local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- I hate Escape
map('i', 'jk', '<Esc>', {})
map('i', 'kj', '<Esc>', {})

-- Easy save
map('n', '<C-s>', ':w<cr>', opts)
map('i', '<C-s>', '<Esc>:w<cr>', opts)

 -- Easier movement
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-p>', ':b #<cr>', opts)

-- No arrows
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- Terminal
map('n', '<C-t>', '<cmd>lua require("FTerm").toggle()<CR>', opts)
map('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
