vim.o.completeopt = 'menu,menuone,noselect'

local luasnip = require'luasnip'
local cmp = require'cmp'

local kind_icons = {
  Class = " | Class",
  Color = " | Color",
  Constant = "ﲀ | Const",
  Constructor = " | Construct",
  Enum = "練| Enum",
  EnumMember = " | EnumMember",
  Event = " | Event",
  Field = " | Field",
  File = "",
  Folder = " ",
  Function = " | Func",
  Interface = "ﰮ | Interface",
  Keyword = " | Keyword",
  Method = " | Method",
  Module = " | Module",
  Operator = " | Operator",
  Property = " | Property",
  Reference = " | Reference",
  Snippet = "  | Snippet",
  Struct = "  | Struct",
  Text = " | Text",
  TypeParameter = " | TypeParam",
  Unit = "塞 | Unit",
  Value = " | Value",
  Variable = " | Variable",
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
}
