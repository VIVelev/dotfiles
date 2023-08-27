-- Set the proper Python host if in venv
local env = os.getenv("CONDA_DEFAULT_ENV")
if not (env == nil or env == "") then
  vim.g.python3_host_prog = os.getenv("MAMBA_ROOT_PREFIX") .. "/envs/" .. env .. "/bin/python"
end

-- Ruff LSP
require "lspconfig".ruff_lsp.setup {}

-- Pyright
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require "lspconfig".pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      }
    }
  },
}
