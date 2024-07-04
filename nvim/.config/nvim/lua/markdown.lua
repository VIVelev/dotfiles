-- Toggle markdown checkbox
vim.keymap.set("n", "<leader>x", function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("%[ %]") then
    new_line = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("%[x%]") then
    new_line = line:gsub("%[x%]", "[ ]", 1)
  else
    return -- No checkbox found, do nothing
  end
  vim.api.nvim_set_current_line(new_line)
end, { desc = "Toggle markdown checkbox", noremap = true, silent = true })

local function auto_insert_checkbox()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*-%s%[%s?%]") then
    return "- [ ] "
  end
  return false
end

local keys = {
  ["cr"] = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("i", "<cr>", function()
      local new_line = auto_insert_checkbox()
      return new_line and keys["cr"] .. new_line or keys["cr"]
    end, { buffer = true, expr = true })
  end,
})
