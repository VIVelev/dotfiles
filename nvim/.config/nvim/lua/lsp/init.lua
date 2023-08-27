-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gdd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gds", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gdx", "<cmd>split<cr><cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gii", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gis", "<cmd>vsplit<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "gix", "<cmd>split<cr><cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)

    local clients = vim.lsp.get_active_clients({ bufnr = ev.buf })
    for i = 1, #clients do
      if clients[i].server_capabilities.documentFormattingProvider then
        local aug = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = aug,
          buffer = ev.buf,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end
  end,
})
