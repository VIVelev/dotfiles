require'packer'.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

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

  -- Formatting & Sorting
  use 'psf/black'
  use 'fisadev/vim-isort'

  -- Comment
  use {'numToStr/Comment.nvim', config = function() require'Comment'.setup() end}

  -- Floating Terminal
  use {'numToStr/FTerm.nvim', config = function() require'FTerm'.setup{ blend = 1 } end}

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

  -- UI
  use {'tami5/lspsaga.nvim', config = function() require'lspsaga'.setup() end}

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
