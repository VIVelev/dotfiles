local capabilities = require("cmp_nvim_lsp").default_capabilities()

require "lspconfig".typst_lsp.setup {
  capabilities = capabilities,
  settings = {
    exportPdf = "onType", -- Choose onType, onSave or never.
    serverPath = "" -- Normally, there is no need to uncomment it.
  }
}
