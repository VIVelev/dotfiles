local lsp = require'lsp'

require'lspconfig'.pyright.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        typeCheckingMode = 'off',
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- Isort
vim.cmd('autocmd BufWritePre *.py :Isort')

-- Black
vim.cmd('autocmd BufWritePre *.py :Black')

-- Flake8
vim.cmd('autocmd BufWritePost *.py call flake8#Flake8()')
vim.g.flake8_show_in_gutter = 1
