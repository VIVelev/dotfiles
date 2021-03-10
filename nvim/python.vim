"Python Host Program
if !empty($VIRTUAL_ENV)
    let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python'
else
    let g:python3_host_prog = '~/.pyenv/shims/python'
endif

" Fix python double autoindent after opening brackets
let g:pyindent_open_paren = 0

" Semshi
let g:semshi#mark_selected_nodes = 0
