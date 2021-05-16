-- Python host
local env = os.getenv('VIRTUAL_ENV')
if not (env == nil or env == '') then
  vim.g.python3_host_prog = env .. '/bin/python'
else
  vim.g.python3_host_prog = '~/.pyenv/shims/python'
end

-- Black
vim.cmd('autocmd BufWritePre *.py :Black')
