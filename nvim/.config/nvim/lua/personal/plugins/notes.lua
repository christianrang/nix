return {
  {
    dir = '~/.config/nvim/lua/personal/plugins/local-plugins-development/notes.nvim',
    config = function()
      local notes = require 'notes'

      vim.keymap.set('n', '<leader>nd', function()
        notes.daily_note()
      end, { desc = 'Open daily note' })

      vim.keymap.set('n', '<leader>nt', function()
        notes.tomorrow_daily_note()
      end, { desc = 'Open daily note' })
    end,
  },
}
