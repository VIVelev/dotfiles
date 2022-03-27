local lsp = require'lsp'

-- Set the proper Python host if in venv
local env = os.getenv('VIRTUAL_ENV')
if not (env == nil or env == '') then
  vim.g.python3_host_prog = env .. '/bin/python'
end

-- Jedi for sweet autocompletition and else
require'lspconfig'.jedi_language_server.setup {
  on_attach = lsp.on_attach,
  -- capabilities = lsp.capabilities(),
}

local python_aug = vim.api.nvim_create_augroup('Python', { clear = true })
-- Black
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.py', command = ':Black', group = python_aug })
-- Isort
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.py', command = ':Isort', group = python_aug })
