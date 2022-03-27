require'telescope'.setup {
  defaults = {
    file_ignore_patterns = { '**/*.min.js' },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
                                       -- the default case_mode is 'smart_case'
    }
  }
}

require'telescope'.load_extension('fzf')
require'telescope'.load_extension('frecency')
require'telescope'.load_extension('ui-select')
require'telescope'.load_extension('file_browser')

local opts = { noremap = true }
local map = vim.api.nvim_set_keymap
map('n', '<leader>ff', ':Telescope find_files<cr>', opts)
map('n', '<leader>gg', ':Telescope live_grep<cr>', opts)
map('n', '<leader>bb', ':Telescope buffers<cr>', opts)
map('n', '<leader>hh', ':Telescope help_tags<cr>', opts)
map('n', '<leader><leader>', ':lua require("telescope").extensions.frecency.frecency()<cr>', opts)
map('n', '<leader>fb', ':Telescope file_browser<cr>', opts)
map('n', '<leader>n', ':Telescope file_browser path=%:p:h<cr>', opts)