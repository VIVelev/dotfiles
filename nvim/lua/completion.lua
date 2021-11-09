vim.o.completeopt = 'menu,menuone,noselect'

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
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
  },
  sources = cmp.config.sources {
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
