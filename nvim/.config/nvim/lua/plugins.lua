local opts = { noremap = true, silent = true }

return {
  -- the colorscheme should be available when starting Neovim
  {
    "marko-cerovac/material.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        dependencies = "kyazdani42/nvim-web-devicons"
      },
    },
    config = function()
      require "material".setup {
        contrast = {
          non_current_windows = true,
        },
        styles = {
          comments = { italic = true },
        },
      }

      vim.g.material_style = "deep ocean"
      vim.keymap.set("n", "ts",
        function() require "material.functions".toggle_style() end)
      vim.cmd.colorscheme "material"
    end,
  },

  -- REPL
  {
    "Olical/conjure",
    ft = { "clojure", "scheme" },
    dependencies = {
      "PaterJason/cmp-conjure",
      "tpope/vim-dispatch",
      "clojure-vim/vim-jack-in",
      "radenling/vim-dispatch-neovim",
    },
    config = function()
      vim.cmd [[
        let g:conjure#client#scheme#stdio#command = "/private/var/folders/s5/zsjzbtvd6q92qwdwtcwj9sm80000gn/T/tmp.xOrpFaGr/mit-scheme-12.1/src/bin/mit-scheme"
      ]]
    end,
  },

  -- LSP & other sources
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },
      { "j-hui/fidget.nvim", branch = "legacy", config = function() require "fidget".setup() end },
    },
  },

  -- Copilot
  { "github/copilot.vim", event = "InsertEnter" },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-copilot",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("completion")
    end,
  },

  -- Motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Comment
  { "numToStr/Comment.nvim", config = function() require "Comment".setup() end },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
  },

  -- Git
  { "lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "tpope/vim-fugitive",

  -- Editing support
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  "tpope/vim-eunuch",
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_method = "skim"
    end,
  },

  -- Text Objects
  "wellle/targets.vim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "guns/vim-sexp", ft = { "clojure", "scheme" } },
  { "tpope/vim-sexp-mappings-for-regular-people", ft = { "clojure", "scheme" } },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    keys = {
      { "<leader>ff", ":Telescope find_files<cr>", opts },
      { "<leader>g", function()
        local utils = require "telescope.utils"
        local builtins = require "telescope.builtin"
        builtins.live_grep({ cwd = utils.buffer_dir() })
      end, opts },
      { "<leader>b", ":Telescope buffers<cr>", opts },
      { "<leader>hh", ":Telescope help_tags<cr>", opts },
      { "<leader>m", ":Telescope man_pages<cr>", opts },
      { "<leader>fb", ":Telescope file_browser<cr>", opts },
      { "<leader>n", ":Telescope file_browser path=%:p:h<cr>", opts },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function()
      local telescope = require "telescope"
      telescope.setup {
        defaults = {
          file_ignore_patterns = { "**/*.min.js" },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        }
      }
      
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
    end,
  },
}
