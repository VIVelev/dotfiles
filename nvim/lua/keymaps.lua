local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- I hate Escape
map('i', 'jk', '<Esc>', {})
map('i', 'kj', '<Esc>', {})

 -- Easier movement
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-p>', ':b #<cr>', opts)

-- Increase/decrease split size
map('n', '<leader>=', '5<C-w>+', opts)
map('n', '<leader>-', '5<C-w>-', opts)
map('n', '<leader>[', '5<C-w><', opts)
map('n', '<leader>]', '5<C-w>>', opts)

-- Easy save
map('n', '<C-w>', ':w<cr>', opts)
map('i', '<C-w>', '<Esc>:w<cr>', opts)

-- Keeping it centered
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Moving text
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('i', '<C-j>', '<esc>:m .+1<CR>==', opts)
map('i', '<C-k>', '<esc>:m .-2<CR>==', opts)
map('n', '<leader>j', ':m .+1<CR>==', opts)
map('n', '<leader>k', ':m .-2<CR>==', opts)

-- No arrows
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- Terminal
map('n', '<C-t>', '<cmd>lua require("FTerm").toggle()<cr>', opts)
map('t', '<C-t>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>', opts)

-- Copilot
map('i', '<C-j>', 'copilot#Accept("<CR>")', { silent = true, script = true, expr = true })
