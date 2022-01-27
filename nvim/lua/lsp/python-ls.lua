local lsp = require'lsp'

require'lspconfig'.pyright.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      },
      venvPath = vim.g.python3_host_prog,
    },
  },
}

-- Python host
local env = os.getenv('VIRTUAL_ENV')
if not (env == nil or env == '') then
  vim.g.python3_host_prog = env .. '/bin/python'
else
  vim.g.python3_host_prog = '~/.pynvim/bin/python'
end

-- Isort
vim.cmd('autocmd BufWritePre *.py :Isort')

-- Black
vim.cmd('autocmd BufWritePre *.py :Black')
