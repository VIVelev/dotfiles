local lsp = require'lsp'

require'lspconfig'.clangd.setup {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = lsp.root_dir('.git/'),
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
}

vim.cmd('autocmd BufWritePre *.c lua vim.lsp.buf.formatting_sync(nil, 1000)')
