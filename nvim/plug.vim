" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

" LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " Python Syntax Highlight

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'                   " Adds filetype-specific icons to NERDTree files and folders
Plug 'Xuyuanp/nerdtree-git-plugin'              " Shows Git status flags for files and folders in NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " Adds syntax highlighting to NERDTree based on filetype
Plug 'PhilRunninger/nerdtree-visual-selection'  " Enables NERDTree to <verb> multiple Visually-selected files at once

" Utils
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'vimwiki/vimwiki'
Plug 'chrisbra/Colorizer'
Plug 'luochen1990/rainbow'

" IPython
Plug 'bfredl/nvim-ipy'

" SLIME
Plug 'vlime/vlime', {'rtp': 'vim/'}

" Initialize plugin system
call plug#end()
