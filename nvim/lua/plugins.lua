require 'paq' {
  -- Paq can manage itself
  'savq/paq-nvim';

  -- LSP
  'neovim/nvim-lspconfig';

  -- Autocomplete
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-vsnip';
  'hrsh7th/nvim-cmp';

  -- Snippets
  'hrsh7th/vim-vsnip';

  -- Co-pilot
  'github/copilot.vim';

  -- Formatting
  'psf/black';

  -- Utils
  'numToStr/Comment.nvim';
  'windwp/nvim-autopairs';

  -- Floating Terminal
  'numToStr/FTerm.nvim';

  -- Git
  'lewis6991/gitsigns.nvim';
  'TimUntersberger/neogit';
  'sindrets/diffview.nvim';

  -- Treesitter
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};

  -- Lua dev
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';

  -- Tree
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';

  -- Telescope
  'nvim-telescope/telescope.nvim';
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'};
  'tami5/sql.nvim';
  'nvim-telescope/telescope-frecency.nvim';

  -- Theme
  'marko-cerovac/material.nvim';

  -- Statusline
  'hoob3rt/lualine.nvim';
}
