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
nnoremap <c-t> :NERDTreeToggle<CR>

" IPython Mappings
let g:nvim_ipy_perform_mappings = 0
map <silent> <c-s> <Plug>(IPy-Run)
map <silent> ß <Plug>(IPy-RunCell)
map <silent> <c-k> <Plug>(IPy-Terminate)

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <Leader>t :call TermToggle(12)<CR>
inoremap <Leader>t <Esc>:call TermToggle(12)<CR>
tnoremap <Leader>t <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>
