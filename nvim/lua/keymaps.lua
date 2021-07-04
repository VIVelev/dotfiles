local opts = { noremap = true }

-- I hate Escape
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {})

 -- Easier movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)
vim.api.nvim_set_keymap('n', '<C-p>', ':b #<CR>', opts)
-- Hop
vim.api.nvim_set_keymap('n', 's', ":HopChar2<cr>", opts)
vim.api.nvim_set_keymap('n', 'S', ":HopWord<cr>", opts)

-- No arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', opts)
