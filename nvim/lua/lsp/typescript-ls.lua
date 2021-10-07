require'lspconfig'.tsserver.setup {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_dir = function(filename)
    local root_files = {
      '.git/',
      'package.json',
      'tsconfig.json',
      'jsconfig.json',
    }
    local util = require'lspconfig'.util
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end,
  on_attach = require'lsp'.on_attach,
  capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}
