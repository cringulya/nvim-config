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
  })
end

return M
