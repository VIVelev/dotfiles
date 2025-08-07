-- Bootstrap mini.deps
local minipath = vim.fn.stdpath("data") .. "/mini"
if not vim.loop.fs_stat(minipath .. "/deps") then
  vim.cmd("!git clone https://github.com/echasnovski/mini.nvim " .. minipath)
end
vim.opt.rtp:prepend(minipath)
require("mini.deps").setup()

vim.g.mapleader = " "
vim.o.showmode = false
vim.o.rnu = true
vim.o.signcolumn = "yes"
vim.o.hlsearch = false
vim.o.scrolloff = 10
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.wrap = false
vim.o.equalalways = false

-- Add plugins
local add = require("mini.deps").add
add({
    source = "echasnovski/mini.nvim",
    -- No need to do anything extra, as `mini.deps` is now managing itself
})
add({
    source = "~/.config/nvim/lua/ipython/",
    config = function() require("ipython") end,
    event = { "CmdPre IPythonConnect", "CmdPre IPythonSend" }
})
add("neovim/nvim-lspconfig")
add({ source = "tpope/vim-ragtag", ft = "html" })
add("tpope/vim-sleuth")
add("tpope/vim-surround")
add({
    source = "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-x>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
        require("oil").setup(opts)
    end,
})

--- Keymaps ---
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- I hate Escape
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

-- Easier movement
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)

-- Moving text
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)
map("n", "<leader>j", ":m .+1<cr>==", opts)
map("n", "<leader>k", ":m .-2<cr>==", opts)

-- Autocomplete mappings
map("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

local keys = {
  ["cr"]        = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
  ["ctrl-y"]    = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><cr>", true, true, true),
}

map("i", "<cr>", function()
  if vim.fn.pumvisible() ~= 0 then
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
  else
    return keys["cr"]
  end
end, { expr = true })

-- Misc
map("n", "<leader>hp", ":lua MiniDiff.toggle_overlay()<cr>", opts)
map("n", "-", ":Oil<cr>", opts)

--- LSP ---
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

vim.lsp.enable("ty")
vim.lsp.enable("clangd")
vim.lsp.enable("ts_ls")
