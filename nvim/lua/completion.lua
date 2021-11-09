local cmp = require'cmp'

local kind_icons = {
  Class = ' | Class',
  Color = ' | Color',
  Constant = 'ﲀ | Const',
  Constructor = ' | Construct',
  Enum = '練| Enum',
  EnumMember = ' | EnumMember',
  Event = ' | Event',
  Field = ' | Field',
  File = '',
  Folder = ' ',
  Function = ' | Func',
  Interface = 'ﰮ | Interface',
  Keyword = ' | Keyword',
  Method = ' | Method',
  Module = ' | Module',
  Operator = ' | Operator',
  Property = ' | Property',
  Reference = ' | Reference',
  Snippet = '  | Snippet',
  Struct = '  | Struct',
  Text = ' | Text',
  TypeParameter = ' | TypeParam',
  Unit = '塞 | Unit',
  Value = ' | Value',
  Variable = ' | Variable',
}

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'vsnip' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
}

-- nvim-autopairs
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
