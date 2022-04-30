local gen = require 'neogen'

gen.setup {
  enabled = true,
  languages = {
    python = {
      template = {
        annotation_convention = 'numpydoc'
      }
    },
    rust = {
      template = {
        annotation_convention = 'rustdoc'
      }
    },
  }
}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Docgen for:
-- Func
map('n', '<leader>dd', function() gen.generate({ type = 'func' }) end, opts)
-- Class
map('n', '<leader>dc', function() gen.generate({ type = 'class' }) end, opts)
-- Type
map('n', '<leader>dt', function() gen.generate({ type = 'type' }) end, opts)
-- File
map('n', '<leader>df', function() gen.generate({ type = 'file' }) end, opts)
