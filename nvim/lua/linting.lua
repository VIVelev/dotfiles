require'lint'.linters_by_ft = {
    python = { 'pylint', --[[ 'mypy' ]] },
}

vim.cmd[[
autocmd BufEnter * lua require'lint'.try_lint()
autocmd BufWritePost * lua require'lint'.try_lint()
]]
