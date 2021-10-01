require'lspconfig'.gopls.setup {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod' },
  root_dir = function(filename)
    local root_files = {
      '.git/',
      'go.mod',
    }
    local util = require'lspconfig'.util
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end,
  on_attach = require'lsp'.on_attach,
  capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

function Goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd('autocmd BufWritePre *.go lua Goimports(1000)')
vim.cmd('autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)')
