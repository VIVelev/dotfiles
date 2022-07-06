require 'material'.setup {
  contrast = {
    non_current_windows = true,
  },
  italics = {
    comments = true,
  },
}

vim.g.material_style = "deep ocean"
vim.cmd [[colorscheme material]]

vim.keymap.set('n', 'tt', function() require 'material.functions'.toggle_style() end)
