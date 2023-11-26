-- Set the proper Python host
local env = os.getenv("CONDA_DEFAULT_ENV")
if not (env == nil or env == "") then
  vim.g.python3_host_prog = os.getenv("MAMBA_ROOT_PREFIX") .. "/envs/" .. env .. "/bin/python"
end

-- Ruff LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require "lspconfig".ruff_lsp.setup {
  capabilities = capabilities,
}

-- Pyright
require "lspconfig".pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
}
