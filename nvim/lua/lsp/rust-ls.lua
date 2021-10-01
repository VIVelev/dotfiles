require'lspconfig'.rust_analyzer.setup {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = function(filename)
    local root_files = {
      '.git/',
      'Cargo.toml',
      'main.rs',
    }
    local util = require'lspconfig'.util
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end,
  on_attach = require'lsp'.on_attach,
  capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
    }
  }
}

vim.cmd('autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)')
