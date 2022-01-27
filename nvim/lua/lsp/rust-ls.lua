local lsp = require'lsp'

require'lspconfig'.rust_analyzer.setup {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = lsp.root_dir('.git/', 'Cargo.toml'),
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
        enableExperimental = true,
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
      lruCapacity = 2048,
    },
  }
}

vim.cmd('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')
