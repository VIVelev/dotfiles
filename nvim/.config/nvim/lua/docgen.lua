require'neogen'.setup {
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

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- Docgen for:
  -- Func
map('n', '<leader>dd', ':lua require("neogen").generate({ type = "func" })<cr>', opts)
  -- Class
map('n', '<leader>dc', ':lua require("neogen").generate({ type = "class" })<cr>', opts)
  -- Type
map('n', '<leader>dt', ':lua require("neogen").generate({ type = "type" })<cr>', opts)
  -- File
map('n', '<leader>df', ':lua require("neogen").generate({ type = "file" })<cr>', opts)
