require'lspconfig'.pyright.setup {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = function(filename)
    local root_files = {
      '.git/',
      '.env/',
    }
    local util = require'lspconfig'.util
    return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
  end,
  on_attach = require'lsp'.on_attach,
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
