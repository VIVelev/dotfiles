vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Setup LSP autocomplete
    vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    -- LSP keymaps
    local opts = { buffer = ev.buf, silent = true }
    local map = vim.keymap.set
    map("n", "gdd", vim.lsp.buf.definition, opts)
    map("n", "gds", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    map("n", "gdx", "<cmd>split<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gii", vim.lsp.buf.implementation, opts)
    map("n", "gis", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    map("n", "gix", "<cmd>split<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    map("n", "<leader>mv", vim.lsp.buf.rename, opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>sd", vim.diagnostic.open_float, opts)
    map("n", "<leader>fm", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    map("v", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Rounded hover window
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
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

-- Haskell
require "lspconfig".hls.setup {}

-- OCaml
require "lspconfig".ocamllsp.setup {}
