return require("packer").startup(
    function (use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- LSP
	use "neovim/nvim-lspconfig"
	use "hrsh7th/nvim-compe"

	-- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

	-- Explorer
	use "kyazdani42/nvim-tree.lua"
	use "kyazdani42/nvim-web-devicons"

	-- theme
	use "marko-cerovac/material.nvim"

	-- statusline
	use {
  	    'hoob3rt/lualine.nvim',
  	    requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
    end
)
