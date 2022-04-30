local lsp = {}
local cmp_lsp = require 'cmp_nvim_lsp'

function lsp.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gdd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gds', '<cmd>vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gdx', '<cmd>split<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gii', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gis', '<cmd>vsplit<CR><cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gix', '<cmd>split<CR><cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<m-k>', '<esc><cmd>lua vim.lsp.buf.signature_help()<CR>i ', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>mv', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    local aug = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = aug,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.formatting_sync()
      end,
    })
  end

  if client.resolved_capabilities.document_highlight then
    local aug = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
    vim.api.nvim_create_autocmd('CursorHold', {
      group = aug,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = aug,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

function lsp.capabilities()
  return cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return lsp
