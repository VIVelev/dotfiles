" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'bfredl/nvim-ipy'

Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end() 
