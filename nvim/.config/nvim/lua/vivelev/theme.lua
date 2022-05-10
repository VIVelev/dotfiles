vim.opt.fillchars:append({
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
})

require 'kanagawa'.setup {
  globalStatus = true,
  dimInactive = true
}

vim.cmd [[colorscheme kanagawa]]
