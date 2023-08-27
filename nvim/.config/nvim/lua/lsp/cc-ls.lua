local capabilities = require("cmp_nvim_lsp").default_capabilities()
require "lspconfig".clangd.setup {
  capabilities = capabilities,
}

local c_aug = vim.api.nvim_create_augroup("C", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePre",
  { pattern = "*.c", callback = function() vim.lsp.buf.format(nil, 1000) end, group = c_aug }
)
