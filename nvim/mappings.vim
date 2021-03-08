" Mappings  
noremap! <c-k> <up>
noremap! <c-j> <down>
noremap! <c-h> <left>
noremap! <c-l> <right>

" GitGutter remap
let g:gitgutter_map_keys = 0
nmap ;] <Plug>(GitGutterNextHunk)
nmap ;[ <Plug>(GitGutterPrevHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

" NERDTree Mappings
map <c-t> :NERDTreeCWD<CR>

" IPython Mappings
let g:nvim_ipy_perform_mappings = 0
map <silent> <c-s> <Plug>(IPy-Run)
map <silent> <c-k> <Plug>(IPy-Terminate)
