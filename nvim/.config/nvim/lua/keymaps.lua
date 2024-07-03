local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- I hate Escape
map("i", "jk", "<esc>:w<cr>")
map("i", "kj", "<esc>:w<cr>")

-- Easier movement
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)

-- Increase/decrease split size
map("n", "<m-=>", "5<c-w>+", opts)
map("n", "<m-->", "5<c-w>-", opts)
map("n", "<m-.>", "5<c-w><", opts)
map("n", "<m-,>", "5<c-w>>", opts)

-- Moving text
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)
map("n", "<leader>j", ":m .+1<cr>==", opts)
map("n", "<leader>k", ":m .-2<cr>==", opts)

-- No arrows
map("n", "<up>", "<nop>", opts)
map("n", "<down>", "<nop>", opts)
map("n", "<left>", "<nop>", opts)
map("n", "<right>", "<nop>", opts)
map("i", "<up>", "<nop>", opts)
map("i", "<down>", "<nop>", opts)
map("i", "<left>", "<nop>", opts)
map("i", "<right>", "<nop>", opts)

-- Nops
map("n", "gd", "<nop>", opts)

-- S-exp
map("x", "ar", "<Plug>(sexp_outer_top_list)")
map("o", "ar", "<Plug>(sexp_outer_top_list)")
map("x", "ir", "<Plug>(sexp_inner_top_list)")
map("o", "ir", "<Plug>(sexp_inner_top_list)")

-- Open pdf dual
map("n", "<m-o>", ":silent !open %:p:s?.typ?.pdf? -a Preview<cr>", opts)

-- Toggle markdown checkbox
map("n", "<leader>x", function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("%[ %]") then
    new_line = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("%[x%]") then
    new_line = line:gsub("%[x%]", "[ ]", 1)
  else
    return -- No checkbox found, do nothing
  end
  vim.api.nvim_set_current_line(new_line)
end, vim.tbl_extend("error", opts, { desc = "Toggle markdown checkbox" }))


-- Autocomplete mappings
map("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
