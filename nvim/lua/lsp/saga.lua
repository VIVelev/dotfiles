require'lspsaga'.init_lsp_saga()
local opts = { noremap = true, silent = true }

-- Async Lsp Finder
vim.api.nvim_set_keymap('n', '<leader>re', ':Lspsaga lsp_finder<CR>', opts)

-- Code Action
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)

-- Hover Doc
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)

-- Rename
vim.api.nvim_set_keymap('n', '<leader>mv', ':Lspsaga rename<CR>', opts)

-- Preview Definition
vim.api.nvim_set_keymap('n', '<leader>dd', ':Lspsaga preview_definition<CR>', opts)

-- Diagnostic
vim.api.nvim_set_keymap('n', '<leader>sd', ':Lspsaga show_line_diagnostics<CR>', opts)
