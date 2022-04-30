local iron = require 'iron'

iron.core.set_config {
  preferred = {
    python = 'ipython',
  }
}

vim.keymap.set('n', '<leader>rp', ':IronRepl<cr>')
