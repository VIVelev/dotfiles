local lsp = require'lsp'

require'lspconfig'.tsserver.setup {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_dir = lsp.root_dir_func({ '.git/', 'package.json' }),
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
}
