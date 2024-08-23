-- What is the <leader> key:
vim.g.mapleader = " "

-- Spelling
vim.o.spell = true

-- Yes, I use the mouse sometimes...
vim.o.mouse = "a"

-- Disable showmode - i.e. Don"t show mode like --INSERT-- in current status line.
vim.o.showmode = false

-- Having longer update time (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 400

-- Relative line number
vim.o.rnu = true

-- Keep signcolumn so it doesn't disturb
vim.o.signcolumn = "yes"

-- Don't highlight search
vim.o.hlsearch = false

-- Keep cursor away from top/bottom
vim.o.scrolloff = 10

-- Ignore case for / and ?
vim.o.ignorecase = true

-- Show a single status bar
vim.o.laststatus = 3

-- Use fancy markdowns
vim.o.conceallevel = 3

-- Don't wrap lines
vim.o.wrap = false

-- Keep panes as they are
vim.o.equalalways = false

-- Custom filetypes for OCaml
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.mll",
  command = "setfiletype ocaml.lex"
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.mly",
  command = "setfiletype ocaml.menhir"
})
