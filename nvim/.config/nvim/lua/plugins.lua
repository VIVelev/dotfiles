return {
  -- LSP & Autocomplete
  "neovim/nvim-lspconfig",

  {
    dir = "~/.config/nvim/lua/ipython/",
    config = function()
      require('ipython')
    end,
    cmd = { "IPythonConnect", "IPythonSend" }
  },

  -- Git
  { "echasnovski/mini.diff", opts = {},  version = "*" },

  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs";
      ---@diagnostic disable: missing-fields
      configs.setup {
        ensure_installed = {
          "c",
          "css",
          "lua",
          "nix",
          "html",
          "bash",
          "fish",
          "vimdoc",
          "python",
          "scheme",
          "haskell",
          "markdown",
          "markdown_inline",
          "javascript",
          "typescript",
        },
        highlight = { enable = true, },
        indent = { enable = false },
      }
    end
  },

  -- Misc
  { "tpope/vim-ragtag",      ft = "html" },
  "tpope/vim-sleuth",
  "tpope/vim-surround",

  -- Tree editor
  {
    "stevearc/oil.nvim",
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
  },

  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<leader>ff", ":Files <cr>",   noremap = true, silent = true },
      { "<leader>n",  ":GFiles <cr>",  noremap = true, silent = true },
      { "<leader>gg", ":Rg<cr>",       noremap = true, silent = true },
      { "<leader>bb", ":Buffers<cr>",  noremap = true, silent = true },
      { "<leader>bf", ":BLines<cr>",   noremap = true, silent = true },
      { "<leader>hh", ":Helptags<cr>", noremap = true, silent = true },
    },
  },
}
