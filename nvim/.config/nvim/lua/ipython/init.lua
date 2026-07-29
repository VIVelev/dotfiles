local M = {}

-- Store the job ID and buffer number of the IPython terminal
local state = {
  job_id = nil,
  buf_nr = nil,
}

-- Bracketed paste markers. IPython (via prompt_toolkit) treats everything
-- between them as a single atomic block.
local BP_START, BP_END = "\27[200~", "\27[201~"

--- Returns true if the IPython job is still running.
-- jobwait with a 0 timeout returns -1 for a running job, -3 for an unknown id.
local function job_alive()
  return state.job_id ~= nil and vim.fn.jobwait({ state.job_id }, 0)[1] == -1
end

function M.connect()
  -- Remember the original window ID before doing anything
  local original_win_id = vim.api.nvim_get_current_win()

  -- Check if a terminal job is already running and seems valid
  if job_alive() and state.buf_nr and vim.api.nvim_buf_is_valid(state.buf_nr) then
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

  local scratch_buf = vim.api.nvim_create_buf(true, true) -- Create unnamed scratch buffer
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

--- Removes the indentation common to every non-blank line.
-- Without this, sending a block lifted out of a function or loop body reaches
-- IPython still indented and raises IndentationError.
-- @param lines table: A table of strings.
-- @return table: The same lines, shifted left to column 0.
local function dedent(lines)
  local indent
  for _, line in ipairs(lines) do
    if line:match("%S") then -- ignore blank lines when measuring
      local width = #line:match("^%s*")
      if not indent or width < indent then indent = width end
    end
  end

  if not indent or indent == 0 then return lines end
  return vim.tbl_map(function(line) return line:sub(indent + 1) end, lines)
end

--- Sends lines of text to the connected IPython terminal.
-- @param lines table: A table of strings, each representing a line.
function M.send_to_repl(lines)
  if not job_alive() then
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

  -- Wrapping the block in bracketed paste makes IPython take it as one unit, so
  -- interior blank lines and indentation don't terminate input early.
  local command_to_send = BP_START .. table.concat(dedent(lines), "\n") .. BP_END .. "\r"

  -- Send the command string to the terminal's job ID
  vim.api.nvim_chan_send(state.job_id, command_to_send)
end

-- Determines the text to send based on the current mode and selection.
-- @param opts table: The options table passed to the user command callback,
--                    containing line1 and line2 for range context.
-- @return table: A table of strings representing the text lines/chunks to send.
local function get_selected_text()
  local buf_nr = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()
  local CTRL_V = "\22"

  -- Outside visual mode there is no selection: send the line under the cursor.
  if mode ~= "v" and mode ~= "V" and mode ~= CTRL_V then
    local row = vim.api.nvim_win_get_cursor(0)[1]
    return vim.api.nvim_buf_get_lines(buf_nr, row - 1, row, false)
  end

  -- getpos returns: [bufnum, lnum, col, off]. "v" is the selection anchor and
  -- "." the cursor; which one comes first depends on the direction the
  -- selection was made in, so normalise them before slicing.
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
    start_pos, end_pos = end_pos, start_pos
  end

  -- Linewise and blockwise selections both send whole lines.
  if mode ~= "v" then
    return vim.api.nvim_buf_get_lines(buf_nr, start_pos[2] - 1, end_pos[2], false)
  end

  -- Charwise: honour the column bounds, whether the selection spans one line or
  -- many. Clamp the end column, which can sit past the last byte (e.g. after v$).
  local last_line = vim.api.nvim_buf_get_lines(buf_nr, end_pos[2] - 1, end_pos[2], false)[1] or ""
  local end_col = math.min(end_pos[3], #last_line)

  return vim.api.nvim_buf_get_text(buf_nr, start_pos[2] - 1, start_pos[3] - 1,
    end_pos[2] - 1, end_col, {})
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
local map_opts = { noremap = true, silent = true }

-- Send current line (Normal mode) -> Calls :IPythonSend on the current line
map({ 'n', 'v' }, '<localleader>ee', "<Cmd>silent IPythonSend<CR>", vim.tbl_extend('keep', {
  desc = "IPython: Send Current Line"
}, map_opts))

-- Send word under cursor (Normal mode)
map('n', '<localleader>ew', 'viw<Cmd>silent IPythonSend<CR>b<Esc>', vim.tbl_extend('keep', {
  desc = "IPython: Send Word Under Cursor"
}, map_opts))

return M -- Not strictly necessary for commands, but good practice if module grows
