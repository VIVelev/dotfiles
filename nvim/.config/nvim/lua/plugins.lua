return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        dependencies = "kyazdani42/nvim-web-devicons"
      },
    },
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
    },
  },

  -- REPL
  {
    "Olical/conjure",
    ft = { "clojure", "scheme", "python" },
    dependencies = {
      "PaterJason/cmp-conjure",
      "tpope/vim-dispatch",
      "clojure-vim/vim-jack-in",
      "radenling/vim-dispatch-neovim",
    },
  },

  -- LSP & other sources
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
      },
    },
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

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
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      { "zbirenbaum/copilot-cmp", opts = {} },
    },
    config = function()
      require("completion")
    end,
  },

  -- Motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- Comment
  { "numToStr/Comment.nvim",           opts = {} },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function() gs.blame_line { full = true } end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end
    },
  },
  "tpope/vim-fugitive",

  -- Editing support
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "tpope/vim-surround",
  "tpope/vim-ragtag",
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  "tpope/vim-eunuch",

  -- Typst
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
  },

  -- Text Objects
  "wellle/targets.vim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "guns/vim-sexp",                              ft = { "clojure", "scheme" } },
  { "tpope/vim-sexp-mappings-for-regular-people", ft = { "clojure", "scheme" } },

  -- Tree editor
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    lazy = false,
    keys = {
      { "<leader>ff", ":Telescope find_files<cr>",              noremap = true, silent = true },
      {
        "<leader>g",
        function()
          local builtins = require "telescope.builtin"
          builtins.live_grep()
        end,
        noremap = true,
        silent = true
      },
      { "<leader>b",  ":Telescope buffers<cr>",                 noremap = true, silent = true },
      { "<leader>hh", ":Telescope help_tags<cr>",               noremap = true, silent = true },
      { "<leader>m",  ":Telescope man_pages<cr>",               noremap = true, silent = true },
      { "<leader>fb", ":Telescope file_browser<cr>",            noremap = true, silent = true },
      { "<leader>n",  ":Telescope file_browser path=%:p:h<cr>", noremap = true, silent = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim",  build = "make" },
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
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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
