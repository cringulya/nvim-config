local M = {}
local icons = require('icons')

M.config = {
  ---@usage disable which-key completely [not recommended]
  setup = {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
      breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
      group = icons.ui.Plus, -- symbol prepended to a group
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    show_help = false, -- show help message on the command line when the popup is visible
  },

  keys = {
    { '<leader>;', '<cmd>Dashboard<CR>', desc = 'Dashboard' },

    {
      '<leader>r',
      require('telescope.builtin').oldfiles,
      desc = 'Recent files',
    },

    {
      '<leader>f',
      function()
        local ok = pcall(
          require('telescope.builtin').git_files,
          { show_untracked = false }
        )
        if not ok then
          require('telescope.builtin').find_files()
        end
      end,
      desc = 'Telescope files',
    },

    { '<leader>H', require('telescope.builtin').help_tags, desc = 'Help' },
    { '<leader>,', require('telescope.builtin').buffers, desc = 'Buffers' },

    {
      '<leader>h',
      '<cmd>nohlsearch<cr><cmd>Noice dismiss<cr>',
      desc = 'No Highlight',
    },

    { "'", group = 'search' },
    {
      "'r",
      require('telescope.builtin').live_grep,
      desc = 'Grep',
    },
    {
      "'c",
      require('telescope.builtin').git_status,
      desc = 'Changed git files',
    },

    { '<leader>g', group = 'Git' },
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Fugitive' },
    {
      '<leader>gj',
      function()
        require('gitsigns').nav_hunk('next')
      end,
      desc = 'Next Hunk',
    },
    {
      '<leader>gk',
      function()
        require('gitsigns').nav_hunk('prev')
      end,
      desc = 'Prev Hunk',
    },
    { '<leader>gl', require('gitsigns').blame_line, desc = 'Blame' },
    { '<leader>gp', require('gitsigns').preview_hunk, desc = 'Preview Hunk' },
    { '<leader>gr', require('gitsigns').reset_hunk, desc = 'Reset Hunk' },
    { '<leader>gR', require('gitsigns').reset_buffer, desc = 'Reset Buffer' },
    { '<leader>gs', require('gitsigns').stage_hunk, desc = 'Stage Hunk' },
    {
      '<leader>gu',
      require('gitsigns').undo_stage_hunk(),
      desc = 'Undo Stage Hunk',
    },
    {
      '<leader>go',
      '<cmd>Telescope git_status<cr>',
      desc = 'Open changed file',
    },
    {
      '<leader>gb',
      '<cmd>Telescope git_branches<cr>',
      desc = 'Checkout branch',
    },
    {
      '<leader>gc',
      '<cmd>Telescope git_commits<cr>',
      desc = 'Checkout commit',
    },
    {
      '<leader>gC',
      '<cmd>Telescope git_bcommits<cr>',
      desc = 'Checkout commit(for current file)',
    },
    { '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', desc = 'Git Diff' },
  },
}

M.setup = function()
  local wk = require('which-key')

  wk.setup(M.config.setup)
  wk.add(M.config.keys)
end

return M
