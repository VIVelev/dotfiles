local checkbox = "^%s*-%s%[[%sx]?%]"

local function toggle_checkbox()
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
end

local usual_insert = vim.fn.maparg("<cr>", "i", false, true).callback
local function insert_checkbox()
  local new_line = usual_insert()
  local line = vim.api.nvim_get_current_line()
  local item_not_selected = vim.fn.complete_info()["selected"] == -1
  if line:match(checkbox) and item_not_selected then
    new_line = new_line .. "- [ ] "
  end
  return new_line
end

local function indent_checkbox()
  local line = vim.api.nvim_get_current_line()
  local pum_not_visible = vim.fn.pumvisible() == 0
  if line:match(checkbox) and pum_not_visible then
    vim.api.nvim_set_current_line("  " .. line)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_win_set_cursor(0, { row, col + 2 })
  else
    -- Select next item from pum
    local cn = vim.api.nvim_replace_termcodes("<C-n>",
      true, true, true)
    vim.fn.feedkeys(cn, "i")
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Toggle checkbox
    vim.keymap.set("n", "<leader>x", toggle_checkbox,
      { buffer = true, silent = true })
    -- New line
    vim.keymap.set("i", "<cr>", insert_checkbox,
      { buffer = true, expr = true })
    -- Indent checkbox
    vim.keymap.set("i", "<tab>", indent_checkbox,
      { buffer = true, silent = true })
  end,
})
