vim.g.nvim_tree_follow          = 1  -- 0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markrs   = 1  -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl          = 1  -- 0 by default, will enable file highlight for git attributes (can be used without the icons)
vim.g.nvim_tree_add_trailing    = 1  -- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_lsp_diagnostics = 1  -- 0 by default, will show lsp diagnostics in the signcolumn; see :help nvim_tree_lsp_diagnostics

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    -- default mappings
    ['<CR>']           = tree_cb('edit'),
    ['o']              = tree_cb('edit'),
    ['<C-]>']          = tree_cb('cd'),
    ['<C-v>']          = tree_cb('vsplit'),
    ['<C-x>']          = tree_cb('split'),
    ['<C-t>']          = tree_cb('tabnew'),
    ['<']              = tree_cb('prev_sibling'),
    ['>']              = tree_cb('next_sibling'),
    ['<BS>']           = tree_cb('close_node'),
    ['<S-CR>']         = tree_cb('close_node'),
    ['<Tab>']          = tree_cb('preview'),
    ['I']              = tree_cb('toggle_ignored'),
    ['H']              = tree_cb('toggle_dotfiles'),
    ['R']              = tree_cb('refresh'),
    ['a']              = tree_cb('create'),
    ['d']              = tree_cb('remove'),
    ['m']              = tree_cb('rename'),
    ['<C-r>']          = tree_cb('full_rename'),
    ['x']              = tree_cb('cut'),
    ['c']              = tree_cb('copy'),
    ['p']              = tree_cb('paste'),
    ['[c']             = tree_cb('prev_git_item'),
    [']c']             = tree_cb('next_git_item'),
    ['-']              = tree_cb('dir_up'),
    ['q']              = tree_cb('close'),
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', {noremap = true})
