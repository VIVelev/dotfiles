require 'material'.setup {
  contrast = {
    non_current_windows = true,
  },
  styles = {
    comments = { italic = true, },
  },
}

vim.g.material_style = "deep ocean"
vim.cmd.colorscheme "material"

vim.keymap.set('n', 'ts', function() require 'material.functions'.toggle_style() end)
