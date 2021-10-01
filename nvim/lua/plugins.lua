require 'paq' {
  -- Paq can manage itself
  'savq/paq-nvim';

  -- LSP
  'neovim/nvim-lspconfig';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/nvim-cmp';

  -- Snip
  'L3MON4D3/LuaSnip';
  'saadparwaiz1/cmp_luasnip';

  -- Formatting
  'psf/black';

  -- Utils
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
