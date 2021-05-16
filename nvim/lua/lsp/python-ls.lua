require'lspconfig'.pyright.setup {
  cmd = { 'pyright-langserver', '--stdio' },
  on_attach = require'lsp'.on_attach,
  settings = {
    organizeimports = {
      provider = 'pyright',
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    }
  },
}

vim.cmd('autocmd BufWritePre *.py :PyrightOrganizeImports')
