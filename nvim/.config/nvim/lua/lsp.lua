vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf)
    end
    -- LSP keymaps
    local opts = { buffer = ev.buf, silent = true }
    local map = vim.keymap.set
    map("n", "<leader>fm", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    map("v", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- C
require "lspconfig".clangd.setup {}

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require "lspconfig".lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Nix
require "lspconfig".nil_ls.setup {}

-- Ruff
require "lspconfig".ruff.setup {}

-- Python
require "lspconfig".basedpyright.setup {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}

-- TypeScript/JavaScript
require "lspconfig".ts_ls.setup {}
