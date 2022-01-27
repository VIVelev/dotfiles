local lsp = require'lsp'

require'lspconfig'.clangd.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
}

vim.cmd('autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 1000)')
