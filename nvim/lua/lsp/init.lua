local lsp = {}
function lsp.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- symbols for autocomplete
  vim.lsp.protocol.CompletionItemKind = {
    '   (Text) ',
    '   (Method)',
    '   (Function)',
    '   (Constructor)',
    ' ﴲ  (Field)',
    '[] (Variable)',
    '   (Class)',
    ' ﰮ  (Interface)',
    '   (Module)',
    ' 襁 (Property)',
    '   (Unit)',
    '   (Value)',
    ' 練 (Enum)',
    '   (Keyword)',
    '   (Snippet)',
    '   (Color)',
    '   (File)',
    '   (Reference)',
    '   (Folder)',
    '   (EnumMember)',
    ' ﲀ  (Constant)',
    ' ﳤ  (Struct)',
    '   (Event)',
    '   (Operator)',
    '   (TypeParameter)'
  }

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', 'ff', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end

  -- Saga
  require'lspsaga'.init_lsp_saga()

  -- Async Lsp Finder
  buf_set_keymap('n', '<leader>re', ':Lspsaga lsp_finder<CR>', opts)

  -- Code Action
  buf_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)

  -- Hover Doc
  buf_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', opts)
  buf_set_keymap('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', opts)

  -- Rename
  buf_set_keymap('n', '<leader>mv', ':Lspsaga rename<CR>', opts)

  -- Preview Definition
  buf_set_keymap('n', '<leader>dd', ':Lspsaga preview_definition<CR>', opts)

  -- Diagnostic
  buf_set_keymap('n', '<leader>sd', ':Lspsaga show_line_diagnostics<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

return lsp
