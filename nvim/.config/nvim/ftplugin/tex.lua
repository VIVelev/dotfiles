vim.b.tabstop = 2
vim.b.shiftwidth = 2
vim.b.expandtab = true

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
