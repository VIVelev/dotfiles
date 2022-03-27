local lsp = require'lsp'

require'lspconfig'.rust_analyzer.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities(),
  settings = {
    ['rust-analyzer'] = {
      assist = {
          importGranularity = "module",
          importPrefix = "by_self",
      },
      cargo = {
          loadOutDirsFromCheck = true
      },
      procMacro = {
          enable = true
      },
      checkOnSave = {
        command = 'clippy',
      },
      inlayHints = {
        chainingHints = false,
        parameterHints = false,
        typeHints = false,
        hideNamedConstructorHints = true,
      },
      lens = {
        enable = false,
      },
      lruCapacity = 4000000000, -- 4GB
    },
  }
}

local rust_aug = vim.api.nvim_create_augroup('Rust', { clear = true })
vim.api.nvim_create_autocmd(
  'BufWritePre',
  { pattern = '*.rs', callback = function () vim.lsp.buf.formatting_sync(nil, 1000) end, group = rust_aug }
)
