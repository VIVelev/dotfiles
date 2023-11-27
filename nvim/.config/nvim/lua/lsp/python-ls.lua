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
  on_attach = function(client, bufnr)
    -- Detach from Conjure buffers
    local buffer_name = vim.api.nvim_buf_get_name(bufnr)
    if string.find(buffer_name, "conjure") then
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
  end,
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
