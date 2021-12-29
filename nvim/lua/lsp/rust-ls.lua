local lsp = require'lsp'

require'rust-tools'.setup {
  server = {
    filetypes = { 'rust' },
    root_dir = lsp.root_dir('.git/', 'Cargo.toml'),
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities(),
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
      },
    }
  }
}

vim.cmd('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')
