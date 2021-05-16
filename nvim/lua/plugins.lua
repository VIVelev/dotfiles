return require'packer'.startup(
  function (use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP & Completion
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'hrsh7th/nvim-compe'

    -- Formatting
    use 'psf/black'

    -- Pairs
    use {
      'windwp/nvim-autopairs',
      config = function ()
        require('nvim-autopairs').setup()
      end
    }

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Theme
    use 'marko-cerovac/material.nvim'

    -- Statusline
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'}
    }

    -- Utils
    use 'tweekmonster/startuptime.vim'
  end
)
