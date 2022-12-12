local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- I hate Escape
map('i', 'jk', '<esc>')
map('i', 'kj', '<esc>')

-- Easier movement
map('n', '<c-h>', '<c-w>h', opts)
map('n', '<c-j>', '<c-w>j', opts)
map('n', '<c-k>', '<c-w>k', opts)
map('n', '<c-l>', '<c-w>l', opts)

-- Increase/decrease split size
map('n', '<m-=>', '5<c-w>+', opts)
map('n', '<m-->', '5<c-w>-', opts)
map('n', '<m-[>', '5<c-w><', opts)
map('n', '<m-]>', '5<c-w>>', opts)

-- Easy save
map('n', '<c-w>', ':w<cr>', opts)
map('i', '<c-w>', '<Esc>:w<cr>', opts)

-- Keeping it centered
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Moving text
map('v', 'J', ":m '>+1<cr>gv=gv", opts)
map('v', 'K', ":m '<-2<cr>gv=gv", opts)
map('i', '<c-j>', '<esc>:m .+1<cr>==', opts)
map('i', '<c-k>', '<esc>:m .-2<cr>==', opts)
map('n', '<leader>j', ':m .+1<cr>==', opts)
map('n', '<leader>k', ':m .-2<cr>==', opts)

-- No arrows
map('n', '<up>', '<nop>', opts)
map('n', '<down>', '<nop>', opts)
map('n', '<left>', '<nop>', opts)
map('n', '<right>', '<nop>', opts)

-- Nops
map('n', 'gd', '<nop>', opts)

-- Terminal
map('n', '<c-t>', function() require('FTerm').toggle() end, opts)
map('t', '<c-t>', '<c-\\><c-n><cmd>lua require("FTerm").toggle()<cr>', opts)

-- S-exp
map('x', 'ar', '<Plug>(sexp_outer_top_list)')
map('o', 'ar', '<Plug>(sexp_outer_top_list)')
map('x', 'ir', '<Plug>(sexp_inner_top_list)')
map('o', 'ir', '<Plug>(sexp_inner_top_list)')

-- Magma
vim.cmd [[
  nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
  nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
  xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
  nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
  nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
  nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>
  
  let g:magma_automatically_open_output = v:false
  let g:magma_image_provider = "kitty"
]]
