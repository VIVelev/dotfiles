require 'paq' {
  -- Paq can manage itself
  'savq/paq-nvim';

  -- LSP
  'neovim/nvim-lspconfig';
  'glepnir/lspsaga.nvim';

  -- Completion
  'hrsh7th/nvim-compe';

  -- Formatting
  'psf/black';

  -- Markdown
  {'npxbr/glow.nvim', run = ':GlowInstall'};

  -- Utils
  'windwp/nvim-autopairs';
  'b3nj5m1n/kommentary';

  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};

  -- Explorer
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'tami5/sql.nvim';
  'nvim-telescope/telescope-frecency.nvim';
  'folke/trouble.nvim';

  -- Theme
  'marko-cerovac/material.nvim';

  -- Statusline
  'hoob3rt/lualine.nvim';

  -- Git
  'lewis6991/gitsigns.nvim';
  'TimUntersberger/neogit';

  -- Floating Terminal
  'numtostr/FTerm.nvim';
}
