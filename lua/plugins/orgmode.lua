local M = {}

M.config = {
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
}

M.setup = function()
  require('orgmode').setup(M.config)
  local wk = require('which-key')
  wk.add({
    { '<leader>o', group = 'Org' },
    { '<leader>of', '<cmd>Telescope find_files search_dirs=~/org<cr>' },
  })
end

return M
