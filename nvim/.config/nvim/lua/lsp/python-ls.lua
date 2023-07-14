local lsp = require "lsp"

require "lspconfig".pyright.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
}
