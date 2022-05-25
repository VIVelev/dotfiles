local iron = require('iron.core')

iron.setup {
  config = {
    -- If iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      python = {
        command = { 'ipython' }
      },
      scheme = {
        command = { 'chibi-scheme' }
      },
    },
    repl_open_cmd = require('iron.view').curry.right(50),
    -- how the REPL window will be opened, the default is opening
    -- a float window of height 40 at the bottom.
  },
  -- Iron doesn't set keymaps by default anymore. Set them here
  -- or use `should_map_plug = true` and map from you vim files
  keymaps = {
    send_motion = '<localleader>s',
    visual_send = '<localleader>s',
    send_line = '<localleader>sl',
    repeat_cmd = '<localleader>.',
    cr = '<localleader><cr>',
    interrupt = '<localleader>st',
    exit = '<localleader>q',
    clear = '<localleader>cl',
  }
}
