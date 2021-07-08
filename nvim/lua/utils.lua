require'nvim-autopairs'.setup{
  check_ts = true,
}

require'kommentary.config'.configure_language('default', {
    prefer_single_line_comments = true,
})

require'hop'.setup{ keys = 'etovxqpdygfblzhckisuran' }
require('FTerm').setup()
