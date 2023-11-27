local cmp = require "cmp"

local kind_icons = {
  Text = "󰉿 | Text",
  Method = "󰆧 | Method",
  Function = "󰊕 | Function",
  Constructor = " | Constructor",
  Field = "󰜢 | Field",
  Variable = "󰀫 | Variable",
  Class = "󰠱 | Class",
  Interface = " | Interface",
  Module = " | Module",
  Property = "󰜢 | Property",
  Unit = "󰑭 | Unit",
  Value = "󰎠 | Value",
  Enum = " | Enum",
  Keyword = "󰌋 | Keyword",
  Snippet = " | Snippet",
  Color = "󰏘 | Color",
  File = "󰈙 | File",
  Reference = "󰈇 | Reference",
  Folder = "󰉋 | Folder",
  EnumMember = " | EnumMember",
  Constant = "󰏿 | Constant",
  Struct = "󰙅 | Struct",
  Event = " | Event",
  Operator = "󰆕 | Operator",
  TypeParameter = "TypeParameter",
  Copilot = " | Copilot",
}
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
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
    { name = "conjure" },
    { name = "copilot" },
    { name = "luasnip" },
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
