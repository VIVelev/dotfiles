vim.cmd [[
function! s:TexFocusVim() abort
  silent execute "!open -a Kitty"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END
]]
