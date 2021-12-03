local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local list = {
  { key = {'o', '<2-LeftMouse>'}, cb = tree_cb('edit') },
  { key = '<C-]>',                cb = tree_cb('cd') },
  { key = '<C-v>',                cb = tree_cb('vsplit') },
  { key = '<C-x>',                cb = tree_cb('split') },
  { key = '<C-t>',                cb = tree_cb('tabnew') },
  { key = 'P',                    cb = tree_cb('parent_node') },
  { key = '<BS>',                 cb = tree_cb('close_node') },
  { key = 'I',                    cb = tree_cb('toggle_ignored') },
  { key = 'H',                    cb = tree_cb('toggle_dotfiles') },
  { key = 'R',                    cb = tree_cb('refresh') },
  { key = 'a',                    cb = tree_cb('create') },
  { key = 'd',                    cb = tree_cb('remove') },
  { key = 'm',                    cb = tree_cb('rename') },
  { key = 'x',                    cb = tree_cb('cut') },
  { key = 'c',                    cb = tree_cb('copy') },
  { key = 'p',                    cb = tree_cb('paste') },
  { key = 'y',                    cb = tree_cb('copy_name') },
  { key = 'Y',                    cb = tree_cb('copy_path') },
  { key = 'ay',                   cb = tree_cb('copy_absolute_path') },
  { key = '-',                    cb = tree_cb('dir_up') },
  { key = 's',                    cb = tree_cb('system_open') },
  { key = '?',                    cb = tree_cb('toggle_help') },
}

vim.g.nvim_tree_indent_markrs = 1  -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl        = 1  -- 0 by default, will enable file highlight for git attributes (can be used without the icons)
vim.g.nvim_tree_add_trailing  = 1  -- 0 by default, append a trailing slash to folder names

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})

require'nvim-tree'.setup {
  open_on_setup = false,
  auto_close = false,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  system_open = {
    cmd = 'open',
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },

  view = {
    width = '11%',
    auto_resize = true,
    mappings = {
      custom_only = true,
      list = list,
    },
  },
}
