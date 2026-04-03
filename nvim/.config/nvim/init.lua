vim.loader.enable()

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
vim.o.mouse = 'a'
vim.o.spell = true

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

--- Plugins ---
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/tpope/vim-surround",
  { src = "https://github.com/echasnovski/mini.diff", version = vim.version.range("*") },
  "https://github.com/stevearc/oil.nvim",
})

require("mini.diff").setup({})

require("oil").setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-x>"] = "actions.select_split",
  },
  view_options = { show_hidden = true },
})

-- Lazy-load vim-ragtag on html filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/tpope/vim-ragtag" })
  end,
})

-- IPython is a local plugin already on the runtimepath
require("ipython")

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
  end,
})

vim.lsp.enable("ty")
vim.lsp.enable("clangd")
vim.lsp.enable("ts_ls")
