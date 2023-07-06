local cmp = require "cmp"
local luasnip = require "luasnip"

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

-- Load snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

-- Setup snippet engine
luasnip.config.set_config({
  -- Don't store snippet history for less overhead
  history = false,
  -- Allow autotrigger snippets
  enable_autosnippets = true,
  -- For equivalent of UltiSnips visual selection
  store_selection_keys = "<Tab>",
})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
    ["<M-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-q>"] = cmp.mapping.complete(),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "conjure" },
    { name = "copilot" },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = "rounded",
    },
  },
}
