require 'packer'.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- nvim speed-up
  use 'lewis6991/impatient.nvim'

  -- Repl
  use 'hkupty/iron.nvim'

  -- LSP & other sources
  use 'neovim/nvim-lspconfig'
  use { 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'j-hui/fidget.nvim', config = function() require 'fidget'.setup() end }

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    }
  }

  -- Motion
  use { 'ggandor/leap.nvim', config = function() require 'leap'.set_default_keymaps() end }

  -- Autopairs
  use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup({ enable_check_bracket_line = false }) end }

  -- Copilot
  use 'github/copilot.vim'

  -- Comment
  use { 'numToStr/Comment.nvim', config = function() require 'Comment'.setup() end }

  -- Docgen
  use { 'danymat/neogen', requires = 'nvim-treesitter/nvim-treesitter' }

  -- Floating Terminal
  use { 'numToStr/FTerm.nvim', config = function() require 'FTerm'.setup { border = "double", blend = 1 } end }

  -- Git
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb' -- vim-fugitive github extension

  -- Editing support
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-repeat'
  use 'guns/vim-sexp'
  use 'wellle/targets.vim'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-frecency.nvim', requires = { 'tami5/sqlite.lua', 'kyazdani42/nvim-web-devicons' } }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  -- Theme
  use 'rebelot/kanagawa.nvim'

  -- Statusline
  use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
end)
