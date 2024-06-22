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

  -- REPL
  {
    "Olical/conjure",
    ft = { "scheme" },
    init = function()
      vim.g["conjure#mapping#doc_word"] = false
      vim.g["conjure#client#scheme#stdio#command"] = "csi -quiet -:c"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "\n-#;%d-> "
    end,
    config = function()
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
  },

  -- LSP & other sources
  "neovim/nvim-lspconfig",

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        keymap = { open = "<C-CR>" },
      },
    },
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    opts = function()
      local cmp = require "cmp"

      local kind_icons = {
        Text = "󰉿 | Text",
        Method = "󰆧 | Method",
        Function = "󰊕 | Function",
        Constructor = " | Constructor",
        Field = "󰜢 | Field",
        Variable = "󰀫 | Variable",
        Class = "󰠱 | Class",
        Interface = " | Interface",
        Module = " | Module",
        Property = "󰜢 | Property",
        Unit = "󰑭 | Unit",
        Value = "󰎠 | Value",
        Enum = " | Enum",
        Keyword = "󰌋 | Keyword",
        Snippet = " | Snippet",
        Color = "󰏘 | Color",
        File = "󰈙 | File",
        Reference = "󰈇 | Reference",
        Folder = "󰉋 | Folder",
        EnumMember = " | EnumMember",
        Constant = "󰏿 | Constant",
        Struct = "󰙅 | Struct",
        Event = " | Event",
        Operator = "󰆕 | Operator",
        TypeParameter = "TypeParameter",
      }

      return {
        mapping = {
          ["<CR>"] = cmp.mapping.confirm(),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-q>"] = cmp.mapping.complete(),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.close(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        },
        formatting = {
          format = function(_, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            return vim_item
          end,
        },
        window = {
          documentation = {
            border = "rounded",
          },
        },
      }
    end
  },

  -- Comment
  { "numToStr/Comment.nvim", opts = {} },

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
    build = ":TSUpdate",
    lazy = false,
    priority = 999,
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
          "javascript",
          "typescript",
        },
        highlight = {
          enable = true, -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = false,
        },
        textobjects = {
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

  -- I know my Pope!
  "tpope/vim-surround",
  { "tpope/vim-ragtag",      ft = "html" },
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  "tpope/vim-eunuch",

  -- Typst
  { "kaarmu/typst.vim", ft = "typst" },

  -- Text Objects
  "wellle/targets.vim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "guns/vim-sexp",    ft = { "scheme" } },

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
      { "<leader>ff", ":Files <cr>",      noremap = true, silent = true },
      { "<leader>gf", ":GFiles <cr>",     noremap = true, silent = true },
      { "<leader>n",  ":Files %:p:h<cr>", noremap = true, silent = true },
      { "<leader>gg", ":Rg<cr>",          noremap = true, silent = true },
      { "<leader>bb", ":Buffers<cr>",     noremap = true, silent = true },
      { "<leader>bf", ":BLines<cr>",      noremap = true, silent = true },
      { "<leader>hh", ":Helptags<cr>",    noremap = true, silent = true },
      { "<leader>jj", ":Jumps<cr>",       noremap = true, silent = true },
    },
  },
}
