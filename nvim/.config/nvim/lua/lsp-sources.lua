local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.fish,

    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.diagnostics.mypy,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      local augroup = vim.api.nvim_create_augroup("NullLsFormatting", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
}
