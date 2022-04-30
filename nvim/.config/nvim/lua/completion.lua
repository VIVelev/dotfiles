local cmp = require 'cmp'

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
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-s>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'vsnip' },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = 'rounded',
    },
  },
}

-- nvim-autopairs
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
