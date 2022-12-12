local lsp = require 'vivelev.lsp'

-- Set the proper Python host if in venv
local env = os.getenv('VIRTUAL_ENV')
if not (env == nil or env == '') then
  vim.g.python3_host_prog = env .. '/bin/python'
end

require 'lspconfig'.pyright.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
}
