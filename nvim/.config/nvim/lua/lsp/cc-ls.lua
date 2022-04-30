local lsp = require 'lsp'

require 'lspconfig'.clangd.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
}

local c_aug = vim.api.nvim_create_augroup('C', { clear = true })
vim.api.nvim_create_autocmd(
  'BufWritePre',
  { pattern = '*.c', callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end, group = c_aug }
)
