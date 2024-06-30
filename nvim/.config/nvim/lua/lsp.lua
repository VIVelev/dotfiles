vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gdd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gds", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gdx", "<cmd>split<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gii", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gis", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "gix", "<cmd>split<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>mv", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>fm", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set("v", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false -- I don't like snippets!

-- C
require "lspconfig".clangd.setup { capabilities = capabilities }

-- Lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require "lspconfig".lua_ls.setup {
  capabilities = capabilities,
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
require "lspconfig".nil_ls.setup { capabilities = capabilities }

-- Ruff
require "lspconfig".ruff_lsp.setup {
  on_attach = function(client, bufnr)
    -- Detach from Conjure buffers
    local buffer_name = vim.api.nvim_buf_get_name(bufnr)
    if string.find(buffer_name, "conjure") then
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
  end,
  capabilities = capabilities,
}

-- Python
require "lspconfig".pylsp.setup {
  on_attach = function(client, bufnr)
    -- Detach from Conjure buffers
    local buffer_name = vim.api.nvim_buf_get_name(bufnr)
    if string.find(buffer_name, "conjure") then
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
  end,
  capabilities = capabilities,
}

-- TypeScript/JavaScript
require "lspconfig".tsserver.setup { capabilities = capabilities }

-- Haskell
require "lspconfig".hls.setup { capabilities = capabilities }

-- Typst
require "lspconfig".typst_lsp.setup {
  capabilities = capabilities,
  settings = {
    exportPdf = "onType", -- Choose onType, onSave or never.
    serverPath = ""       -- Normally, there is no need to uncomment it.
  }
}
