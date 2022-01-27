local lsp = require'lsp'

require'lspconfig'.rust_analyzer.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    ['rust-analyzer'] = {
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

vim.cmd('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')
