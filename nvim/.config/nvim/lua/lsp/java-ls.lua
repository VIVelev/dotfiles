-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/Users/vivelev/.cache/jdtls/workspace/" .. project_name

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require "lspconfig".jdtls.setup {
  cmd = {
    "jdt-language-server",
    "-configuration", "/Users/vivelev/.cache/jdtls/config",
    "-data", workspace_dir,
  },
  capabilities = capabilities,
  settings = {
    java = {
      format = {
        enabled = false,
      },
    },
  },
}
