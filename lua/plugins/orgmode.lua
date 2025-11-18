local M = {}

local Menu = require('org-modern.menu')

M.config = {
  ui = {
    menu = {
      handler = function(data)
        Menu:new({
          window = {
            margin = { 1, 0, 1, 0 },
            padding = { 0, 1, 0, 1 },
            title_pos = 'center',
            border = 'single',
            zindex = 1000,
          },
          icons = {
            separator = '➜',
          },
        }):open(data)
      end,
    },
  },
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
  org_startup_indented = true,
  win_split_mode = 'float',
  org_startup_folded = 'content',
  org_highlight_latex_and_related = 'native',
}

M.setup = function()
  require('orgmode').setup(M.config)
  require('org-bullets').setup()
  local wk = require('which-key')
  wk.add({
    { '<leader>o',  group = 'Org' },
    { '<leader>of', '<cmd>Telescope find_files search_dirs=~/org<cr>' },
  })
end

return M
