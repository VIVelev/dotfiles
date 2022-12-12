local lsp = require 'vivelev.lsp'

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/vivelev/.cache/jdtls/workspace/' .. project_name

require 'lspconfig'.jdtls.setup {
  cmd = {
    'jdt-language-server',
    '-configuration', '/home/vivelev/.cache/jdtls/config',
    '-data', workspace_dir,
  },
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
  settings = {
    java = {
      format = {
        enabled = false,
      },
    },
  },
}
