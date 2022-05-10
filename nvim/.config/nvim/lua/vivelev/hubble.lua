require 'telescope'.setup {
  defaults = {
    file_ignore_patterns = { '**/*.min.js' },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
      -- the default case_mode is 'smart_case'
    }
  }
}

require 'telescope'.load_extension('fzf')
require 'telescope'.load_extension('frecency')
require 'telescope'.load_extension('ui-select')
require 'telescope'.load_extension('file_browser')

local opts = { noremap = true, silent = true }
local map = vim.keymap.set
map('n', '<leader>ff', ':Telescope find_files<cr>', opts)
map('n', '<leader>g', ':Telescope live_grep<cr>', opts)
map('n', '<leader>b', ':Telescope buffers<cr>', opts)
map('n', '<leader>h', ':Telescope help_tags<cr>', opts)
map('n', '<leader>m', ':Telescope man_pages<cr>', opts)
map('n', '<leader><leader>', function() require('telescope').extensions.frecency.frecency() end, opts)
map('n', '<leader>fb', ':Telescope file_browser<cr>', opts)
map('n', '<leader>n', ':Telescope file_browser path=%:p:h<cr>', opts)
