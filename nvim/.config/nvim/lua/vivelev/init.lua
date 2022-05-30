function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^vivelev') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

require('vivelev.plugins')
require('vivelev.settings')
require('vivelev.keymaps')

require('vivelev.theme')
require('vivelev.evil_lualine')

require('vivelev.treesitter')
require('vivelev.completion')

require('vivelev.git')
require('vivelev.hubble')

require('vivelev.repl')

require('vivelev.lsp-sources')

require('vivelev.lsp.cc-ls')
require('vivelev.lsp.lua-ls')
require('vivelev.lsp.rust-ls')
require('vivelev.lsp.python-ls')
