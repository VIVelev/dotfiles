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

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})

require'nvim-tree'.setup {
  hijack_cursor = true,
  diagnostics = {
    enable = true,
  },
  system_open = {
    cmd = 'open',
  },
  view = {
    width = '11%',
    preserve_window_proportions = true,
    mappings = {
      custom_only = true,
      list = list,
    },
  },
}
