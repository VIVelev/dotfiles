vim.g.material_style = 'deep ocean'

require('material').setup({
  contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
  borders = false, -- Enable borders between verticaly split windows

  italics = {
    comments = false, -- Enable italic comments
    keywords = false, -- Enable italic keywords
    functions = false, -- Enable italic functions
    strings = false, -- Enable italic strings
    variables = false -- Enable italic variables
  },

  disable = {
    background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
    term_colors = true, -- Prevent the theme from setting terminal colors
    eob_lines = true -- Hide the end-of-buffer lines
  },
})

vim.cmd[[colorscheme material]]
