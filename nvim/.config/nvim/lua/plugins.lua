return {
  -- LSP & Autocomplete
  "neovim/nvim-lspconfig",
  {
    "echasnovski/mini.completion",
    event = "InsertEnter",
    opts = {
      lsp_completion = {
        source_func = "omnifunc",
        auto_setup = false,
      },
    },
    version = "*",
  },

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
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<localleader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<localleader>A"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,
            -- Automatically jump forward to text object, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
              ["il"] = "@call.inner",
              ["al"] = "@call.outer",
              ["ic"] = "@class.inner",
              ["ac"] = "@class.outer",
              ["ik"] = "@comment.inner",
              ["ak"] = "@comment.outer",
              ["id"] = "@conditional.inner",
              ["ad"] = "@conditional.outer",
              ["if"] = "@function.inner",
              ["af"] = "@function.outer",
              ["iu"] = "@loop.inner",
              ["au"] = "@loop.outer",
              ["im"] = "@parameter.inner",
              ["am"] = "@parameter.outer",
            },
          },
        },
      }
    end
  },

  -- Misc
  { "tpope/vim-ragtag",      ft = "html" },
  "tpope/vim-sleuth",
  "tpope/vim-eunuch",
  "tpope/vim-surround",
  { "guns/vim-sexp",       ft = { "scheme" } },
  { "echasnovski/mini.ai", opts = {},        version = "*" },

  -- Tree editor
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
