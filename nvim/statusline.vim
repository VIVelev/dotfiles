"" Adopted from Reddit user "u/SamLovesNotion"
" Add this AFTER `colorscheme` option in your vimrc. Otherwise your colorscheme will clear this highlightngs.

" Define colors
let g:GREEN  = "#2BBB4F"
let g:BLUE   = "#4799EB"
let g:VIOLET = "#986FEC"
let g:YELLOW = "#D7A542"
let g:ORANGE = "#EB754D"

let g:LIGHT  = "#C0C0C0"
let g:DARK   = "#080808"
let g:DARK1  = "#181818"
let g:DARK2  = "#202020"
let g:DARK3  = "#303030"

let g:primary_color         = g:GREEN  " Will be redefined, just a placeholder
let g:primary_color_txt     = g:DARK
let g:secondary_color       = g:DARK3
let g:secondary_colot_txt   = g:LIGHT
let g:bg_color              = g:DARK2

"" Create highlight groups
exe 'hi StatuslineSecColor   guifg=' . g:secondary_colot_txt . ' guibg=' . g:secondary_color
exe 'hi StatuslineSecColorFG guifg=' . g:secondary_color     . ' guibg=' . g:bg_color
exe 'hi StatuslineIconColor  guifg=' . g:YELLOW              . ' guibg=' . g:bg_color

" Statusline

" Enable statusline
set laststatus=2

" Disable showmode - i.e. Don't show mode like --INSERT-- in current statusline.
set noshowmode

" Enable GUI colors for terminals
set termguicolors

" Define Activate Statusline
function! ActivateStatusline()
    call Filetype()

    setlocal statusline  =%#StatuslinePriColor#\ %{Mode()}                                  " VIM mode
    setlocal statusline +=%#StatuslineSecColor#\ %{Branch()!=\"\"?\"\ \":\"\"}%{Branch()}  " Git Branch?
    setlocal statusline +=%#StatuslinePriColorFG#%F                                         " Current File Path
    setlocal statusline +=\ %#IStatuslineconColor#                                          " File Info Icons
    setlocal statusline +=\ %{&readonly?\"\ \":\"\"}                                           " Read-only?
    setlocal statusline +=%{&modified?\"\ \":\"\"}                                             " Modified?

    setlocal statusline +=%=                                                                " Align to the right:
    setlocal statusline +=%#StatuslinePriColorFG#\ %{b:FiletypeIcon}%{&filetype}                " File Icon & Type
    setlocal statusline +=\ %#StatuslineSecColorFG#%#StatuslinePriColorFGSecColorBG#          " Some cool arrows
    setlocal statusline +=%#StatuslinePriColor#\ %p\%%                                          " Percentage %
    setlocal statusline +=\ %#StatuslinePriColorBold#%l%#StatuslinePriColor#/%L                 " Current Line / Total Lines
    setlocal statusline +=\ :%c                                                                 " Current Column

endfunction


" Define Deactive Statusline
function! DeactivateStatusline()
    setlocal statusline  =%#StatuslineSecColor#\ NOTACTIVE  " Display that the current buffer is not active
    setlocal statusline +=%#StatuslinePriColorFG#%F         " Current File Path
    setlocal statusline +=\ %#StatuslineIconColor#          " File Info Icons
    setlocal statusline +=\ %{&readonly?\"\ \":\"\"}           " Read-only?
    setlocal statusline +=%{&modified?\"\ \":\"\"}             " Modified?
endfunction

" Get the current git branch
function! Branch()
    let b:branch = matchstr(FugitiveStatusline(), '\((.*)\)')[1:-2]
    return b:branch
endfunction

" Get Statusline mode & also set primary color for that mode
function! Mode()
    let l:vim_mode = mode()

    if l:vim_mode ==# "n"
        let g:primary_color = g:GREEN
        let b:vim_mode = "NORMAL "

    elseif l:vim_mode ==# "i"
        let g:primary_color = g:VIOLET
        let b:vim_mode = "INSERT "

    elseif l:vim_mode ==# "c"
        let g:primary_color = g:YELLOW
        let b:vim_mode = "COMMAND "

    elseif l:vim_mode ==# "v"
        let g:primary_color = g:BLUE
        let b:vim_mode = "VISUAL "

    elseif l:vim_mode ==# "V"
        let g:primary_color = g:BLUE
        let b:vim_mode = "V-LINE "

    elseif l:vim_mode ==# "\<C-v>"
        let g:primary_color = g:BLUE
        let b:vim_mode = "V-BLOCK "

    elseif l:vim_mode ==# "R"
        let g:primary_color = g:VIOLET
        let b:vim_mode = "REPLACE "

    elseif l:vim_mode ==# "s"
        let g:primary_color = g:BLUE
        let b:vim_mode = "SELECT "

    elseif l:vim_mode ==# "t"
        let g:primary_color =g:YELLOW
        let b:vim_mode = "TERM "

    elseif l:vim_mode ==# "!"
        let g:primary_color = g:YELLOW
        let b:vim_mode = "SHELL "
    endif

    call UpdateColors()

    return b:vim_mode
endfunction


" Update colors. Recreate highlight groups with new Primary color value.
function! UpdateColors()
    exe 'hi StatuslinePriColor             guifg=' . g:primary_color_txt . ' guibg=' . g:primary_color
    exe 'hi StatuslinePriColorFG           guifg=' . g:primary_color     . ' guibg=' . g:bg_color
    exe 'hi StatuslinePriColorBold         guifg=' . g:primary_color_txt . ' guibg=' . g:primary_color . ' gui=bold'
    exe 'hi StatuslinePriColorFGSecColorBG guifg=' . g:primary_color     . ' guibg=' . g:secondary_color
endfunction


" Get filetype & custom icon. Put your most used file types first for optimized performance.
function! Filetype()

    if &filetype == 'python'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'c'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'vim'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'html'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'typescript'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'css'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'javascript'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'javascriptreact'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'markdown'
        let b:FiletypeIcon = ' '

    elseif &filetype == ''
        let b:FiletypeIcon = ''

    elseif &filetype == 'rust'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'cpp'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'go'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'lua'
        let b:FiletypeIcon = ' '

    elseif &filetype == 'haskel'
        let b:FiletypeIcon = ' '

    else
        let b:FiletypeIcon = ' '
    endif

endfunction

" Set active / inactive statusline after entering, leaving buffer
augroup SetStslineline
    autocmd!
    autocmd BufEnter,WinEnter * call ActivateStatusline()
    autocmd BufLeave,WinLeave * call DeactivateStatusline()
augroup END
