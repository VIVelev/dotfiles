local lsp = require'lsp'

require'lspconfig'.pyright.setup {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = lsp.root_dir(
    '.git/',
    '.env/',
    '.venv/',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt'
  ),
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    organizeimports = {
      provider = 'pyright',
    },
    python = {
      analysis = {
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
  vim.g.python3_host_prog = '~/.pyenv/shims/python'
end

-- Pyright imports
--vim.cmd('autocmd BufWritePre *.py :PyrightOrganizeImports')

-- Black
vim.cmd('autocmd BufWritePre *.py :Black')
