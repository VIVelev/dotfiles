local lsp = require'lsp'

-- require'lspconfig'.rust_analyzer.setup {
--   cmd = { '/Users/vivelev/rust-analyzer/target/release/rust-analyzer' },
--   filetypes = { 'rust' },
--   root_dir = lsp.root_dir('.git/', 'Cargo.toml'),
--   on_attach = lsp.on_attach,
--   capabilities = lsp.capabilities(),
--   settings = {
--     ['rust-analyzer'] = {
--       checkOnSave = {
--         command = 'clippy',
--       },
--     }
--   }
-- }
--
-- vim.cmd('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')

require'rust-tools'.setup {
  server = {
    on_attach = lsp.on_attach,
    capabilities = lsp.capabilities(),
  }
}
