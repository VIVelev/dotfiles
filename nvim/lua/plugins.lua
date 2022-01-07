require'packer'.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Rust
  use {
    'simrat39/rust-tools.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }

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
  use 'ggandor/lightspeed.nvim'

  -- Autopairs
  use {'windwp/nvim-autopairs', config = function() require'nvim-autopairs'.setup() end}

  -- Copilot
  use 'github/copilot.vim'

  -- Formatting
  use 'psf/black'

  -- Comment
  use {'numToStr/Comment.nvim', config = function() require'Comment'.setup() end}

  -- Floating Terminal
  use 'numToStr/FTerm.nvim'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      {'sindrets/diffview.nvim', requires = 'kyazdani42/nvim-web-devicons'},
    },
  }

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Tree
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

  -- Telescope
  use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope-frecency.nvim', requires = {'tami5/sqlite.lua', 'kyazdani42/nvim-web-devicons'}}

  -- Trouble
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'trouble'.setup() end,
  }

  -- Theme
  use {
    'marko-cerovac/material.nvim',
    config = function()
      vim.g.material_style = "deep ocean"
      require'material'.setup {
        disable = { background = true }
      }
      vim.cmd[[colorscheme material]]
    end
  }

  -- Statusline
  use {'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons'}
end)
