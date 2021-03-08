" Default colorscheme
colorscheme spacecamp

" Set font
set guifont=FiraMono\ Nerd\ Font:h12

" Plug
source ~/.config/nvim/plug.vim

" CoC
source ~/.config/nvim/coc.vim

" Python
source ~/.config/nvim//python.vim

" Mappings
source ~/.config/nvim//mappings.vim

" Status line
source ~/.config/nvim/statusline.vim

" Line numbers
set rnu

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

" Fix python double autoindent after opening brackets
let g:pyindent_open_paren = 'shiftwidth()'

" make backspaces more powerfull
set backspace=indent,eol,start

" ---- Bonus for proving the setting
" Displays '-' for trailing space, '>-' for tabs and '_' for non breakable space
set listchars=tab:>-,trail:-,nbsp:_
set list

" VSplit right by default
set splitright
