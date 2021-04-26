" Default colorscheme
colorscheme ayu

" Enable GUI colors for terminals
set termguicolors

" Set font
set guifont=FiraMono\ Nerd\ Font:h12

" Plug
source ~/.config/nvim/plug.vim
" CoC
source ~/.config/nvim/coc.vim
" Python
source ~/.config/nvim/python.vim
" Mappings
source ~/.config/nvim/mappings.vim
" Status line
source ~/.config/nvim/statusline.vim
" NERDTree
source ~/.config/nvim/nerdtree.vim

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
set smartindent

set clipboard+=unnamedplus

let g:rainbow_active = 1

" make backspaces more powerfull
set backspace=indent,eol,start

" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
set listchars=tab:>-,trail:-,nbsp:_
set list

" Line numbers
set rnu
set cursorline

set mouse=a

" Performance tweaks
set lazyredraw
set synmaxcol=120

" VSplit right by default
set splitright

" Transparent background
hi Normal guibg=none
hi NonText guibg=none
