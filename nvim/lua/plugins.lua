return require'packer'.startup(
  function (use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'

    -- Completion
    use 'hrsh7th/nvim-compe'

    -- Formatting
    use 'psf/black'

    -- Utils
    use 'windwp/nvim-autopairs'
    use 'b3nj5m1n/kommentary'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
      'nvim-telescope/telescope-frecency.nvim',
      requires = {'tami5/sql.nvim'},
      config = function()
        require'telescope'.load_extension('frecency')
      end
    }
    use 'folke/trouble.nvim'

    -- Movement
    use {
      'phaazon/hop.nvim',
      as = 'hop',
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }

    -- Theme
    use 'marko-cerovac/material.nvim'

    -- Statusline
    use 'hoob3rt/lualine.nvim'

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
    }
    use {
      'TimUntersberger/neogit',
      requires = {'nvim-lua/plenary.nvim'},
    }

    -- Floating Terminal
    use {
      'numtostr/FTerm.nvim',
      config = function()
        require('FTerm').setup()
      end
    }

  end
)
