require'lint'.linters_by_ft = {
    python = { 'pylint', --[[ 'mypy' ]] },
}

local linting_aug = vim.api.nvim_create_augroup('Linting', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', { callback = function () require'lint'.try_lint() end, group = linting_aug })
vim.api.nvim_create_autocmd('BufWritePost', { callback = function () require'lint'.try_lint() end, group = linting_aug })
