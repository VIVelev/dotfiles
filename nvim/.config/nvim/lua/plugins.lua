local treesitter_ft = {
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
}

return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      on_colors = function(colors)
        colors.border = "#565f89"
      end
    },
  },

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

  -- Git
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>vf", ":G<cr>",           silent = true },
      { "<leader>vd", ":Gvdiffsplit<cr>", silent = true },
    }
  },

  -- Tree sitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
    ft = treesitter_ft,
    config = function()
      local configs = require "nvim-treesitter.configs";
      ---@diagnostic disable: missing-fields
      configs.setup {
        ensure_installed = treesitter_ft,
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

  -- Typst
  { "kaarmu/typst.vim", ft = "typst" },

  -- Misc
  { "tpope/vim-ragtag", ft = "html" },
  "tpope/vim-sleuth",
  "tpope/vim-eunuch",
  { "echasnovski/mini.surround", opts = {},        version = "*" },
  { "echasnovski/mini.ai",       opts = {},        version = "*" },
  { "guns/vim-sexp",             ft = { "scheme" } },

  -- Tree editor
  {
    "stevearc/oil.nvim",
    lazy = false, -- Since otherwise "vim ." uses netrw
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

    -- Open parent directory in current window
    keys = {
      { "-", ":Oil<cr>", noremap = true, silent = true },
    }
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
