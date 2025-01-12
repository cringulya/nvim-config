local M = {}

M.config = {
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
  org_startup_indented = true,
}

M.setup = function()
  require('orgmode').setup(M.config)
  require('org-bullets').setup()
  local wk = require('which-key')
  wk.add({
    { '<leader>o', group = 'Org' },
    { '<leader>of', '<cmd>Telescope find_files search_dirs=~/org<cr>' },
  })
end

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'org',
  callback = function()
    vim.opt_local.concealcursor = 'nvci'
    vim.opt_local.conceallevel = 2
    vim.opt_local.colorcolumn = '0'
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    Snacks.indent.disable()
    vim.keymap.set(
      'i',
      '<S-CR>',
      '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>',
      { silent = true, buffer = true }
    )
  end,
})

return M
