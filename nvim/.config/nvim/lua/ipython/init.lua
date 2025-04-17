local M = {}

-- Store the job ID and buffer number of the IPython terminal
local state = {
  job_id = nil,
  buf_nr = nil,
}

function M.connect()
  -- Remember the original window ID before doing anything
  local original_win_id = vim.api.nvim_get_current_win()

  -- Check if a terminal job is already running and seems valid
  if state.job_id and state.buf_nr and vim.api.nvim_buf_is_valid(state.buf_nr) and vim.fn.chansend(state.job_id, "") == 0 then
    vim.notify("IPython terminal already seems to be running (Job ID: " .. state.job_id .. ")",
      vim.log.levels.INFO)
    local found_win = false
    -- Try to find the existing terminal window and focus it
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win_id) then
        local buf_id = vim.api.nvim_win_get_buf(win_id)
        if buf_id == state.buf_nr then
          vim.api.nvim_set_current_win(win_id)
          found_win = true
          break -- Exit loop once found
        end
      end
    end

    if not found_win then
      vim.api.nvim_command('bel vsplit')
      local reopen_win_id = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(reopen_win_id, state.buf_nr)

      -- Switch focus back to the original code window
      if vim.api.nvim_win_is_valid(original_win_id) then
        vim.api.nvim_set_current_win(original_win_id)
      else
        vim.cmd('wincmd p') -- Fallback
      end
    end
    return
  end

  -- Open a new vertical split. Neovim automatically focuses the new window.
  vim.api.nvim_command('bel vsplit')
  local term_win_id = vim.api.nvim_get_current_win()

  local scratch_buf = vim.api.nvim_create_buf(false, true) -- Create unnamed scratch buffer
  if not scratch_buf or scratch_buf == 0 then
    vim.notify("Error: Failed to create scratch buffer.", vim.log.levels.ERROR)
    if vim.api.nvim_win_is_valid(term_win_id) then vim.api.nvim_win_close(term_win_id, true) end -- Close the split
    return
  end
  state.buf_nr = scratch_buf
  vim.api.nvim_win_set_buf(term_win_id, state.buf_nr)

  -- Open the terminal in the current window (the new split)
  local job_id = vim.fn.jobstart('ipython', {
    term = true,
    on_exit = function(j_id, code, event)
      -- Check against the job ID passed to the callback
      if state.job_id == j_id then
        vim.notify("IPython terminal (Job ID: " .. j_id .. ") exited (event: " .. event .. ", code: " .. code .. ")",
          vim.log.levels.INFO)
        state.job_id = nil
        state.buf_nr = nil
      end
    end
  })

  -- Check if termopen succeeded
  if job_id and job_id > 0 then
    state.job_id = job_id
    vim.notify("IPython terminal started (Job ID: " ..
      state.job_id .. ", BufNr: " .. state.buf_nr .. ", WinID: " .. term_win_id .. ")",
      vim.log.levels.INFO)

    -- Explicitly switch focus back to the original window using its ID
    if vim.api.nvim_win_is_valid(original_win_id) then
      vim.api.nvim_set_current_win(original_win_id)
    else
      -- Fallback if original window became invalid somehow
      vim.notify("Original window ID (" .. original_win_id .. ") became invalid! Trying 'wincmd p'.",
        vim.log.levels.WARN)
      vim.cmd('wincmd p') -- Try switching to previous window as a guess
    end
  else
    -- termopen failed
    vim.notify("Failed to start IPython terminal process (job_id: " .. tostring(job_id) .. ").",
      vim.log.levels.ERROR)
    -- Attempt to close the split window we created
    if vim.api.nvim_win_is_valid(term_win_id) then
      vim.api.nvim_win_close(term_win_id, true) -- true = force close
    else
      -- Fallback if we lost track of the window
      vim.cmd('close')
    end
    -- After closing, try to ensure focus returns to the original window if it's still valid
    if vim.api.nvim_win_is_valid(original_win_id) then
      vim.api.nvim_set_current_win(original_win_id)
    end
  end
end

--- Sends lines of text to the connected IPython terminal.
-- @param lines table: A table of strings, each representing a line.
function M.send_to_repl(lines)
  if not state.job_id or vim.fn.chansend(state.job_id, "") ~= 0 then
    -- Check if channel is closed (non-zero return value means error/closed)
    vim.notify("IPython terminal not connected or job has ended. Use :IPythonConnect first.",
      vim.log.levels.ERROR)
    state.job_id = nil -- Clear potentially stale job ID
    state.buf_nr = nil
    return
  end

  -- Check if buffer associated with job still exists and is loaded/listed
  if not state.buf_nr or not vim.api.nvim_buf_is_loaded(state.buf_nr) then
    vim.notify("The buffer associated with the IPython terminal (BufNr: " ..
      (state.buf_nr or 'N/A') .. ") seems to be gone. Use :IPythonConnect.",
      vim.log.levels.ERROR)
    state.job_id = nil
    state.buf_nr = nil
    return
  end

  -- Join lines with <C-q><C-j>
  if string.find(lines[#lines], "return") then
    lines[#lines] = lines[#lines] .. "\n"
  end
  local command_to_send = table.concat(lines, "\x11\x0a") .. "\n"
  vim.print(command_to_send)

  -- Send the command string to the terminal's job ID
  vim.api.nvim_chan_send(state.job_id, command_to_send)
end

-- Determines the text to send based on the current mode and selection.
-- @param opts table: The options table passed to the user command callback,
--                    containing line1 and line2 for range context.
-- @return table: A table of strings representing the text lines/chunks to send.
local function get_selected_text()
  local lines_to_send = {}

  -- getpos returns: [bufnum, lnum, col, off]
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local buf_nr = start_pos[1]

  local is_visual_selection_on_line = buf_nr and
      start_pos[2] == end_pos[2] and
      start_pos[3] ~= end_pos[3]

  if is_visual_selection_on_line then
    local start_row = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_col = end_pos[3]

    -- Fetch the precise text selection using the buffer where selection occurred
    lines_to_send = vim.api.nvim_buf_get_text(buf_nr, start_row, start_col, start_row, end_col, {})
  else
    print(start_pos[2], end_pos[2])
    return vim.api.nvim_buf_get_lines(buf_nr, start_pos[2] - 1, end_pos[2], false)
  end

  return lines_to_send
end

-- Create user commands
vim.api.nvim_create_user_command(
  'IPythonConnect',
  M.connect,
  { nargs = 0, desc = "Open IPython in a vertical split terminal" }
)
vim.api.nvim_create_user_command(
  'IPythonSend',
  function()
    local lines = get_selected_text()
    if lines and #lines > 0 then
      M.send_to_repl(lines)
    else
      vim.notify("IPythonSend: No text selected or retrieved to send.", vim.log.levels.WARN)
    end
  end,
  {
    nargs = 0,
    range = true,
    desc = "Send current line or visual selection (char/line) to IPython"
  }
)

-- Default Keymaps Setup
local map = vim.keymap.set
-- Default options for mappings: non-recursive, silent
local map_opts = { noremap = true, silent = true, buffer = true }

-- Send current line (Normal mode) -> Calls :IPythonSend on the current line
map({ 'n', 'v' }, '<localleader>ee', "<Cmd>silent IPythonSend<CR>", vim.tbl_extend('keep', {
  desc = "IPython: Send Current Line"
}, map_opts))

-- Send word under cursor (Normal mode)
map('n', '<localleader>ew', 'viw<Cmd>silent IPythonSend<CR>b<Esc>', vim.tbl_extend('keep', {
  desc = "IPython: Send Word Under Cursor"
}, map_opts))

return M -- Not strictly necessary for commands, but good practice if module grows
