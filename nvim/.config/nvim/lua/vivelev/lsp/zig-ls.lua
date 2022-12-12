local lsp = require 'vivelev.lsp'

require 'lspconfig'.zls.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
}
