local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("lazy").setup("plugins")
require("keymaps")

require("evil_lualine")
require("treesitter")
require("git")

require("lsp")
require("lsp.cc-ls")
require("lsp.lua-ls")
require("lsp.python-ls")
require("lsp.typst-ls")
