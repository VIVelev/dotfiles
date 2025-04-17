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
