local lsp = require 'lsp'

require 'lspconfig'.rust_analyzer.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    ['rust-analyzer'] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
      checkOnSave = {
        command = 'clippy',
      },
      inlayHints = {
        chainingHints = false,
        parameterHints = false,
        typeHints = false,
        hideNamedConstructorHints = true,
      },
      lens = {
        enable = false,
      },
      lruCapacity = 4000000000, -- 4GB
    },
  }
}
