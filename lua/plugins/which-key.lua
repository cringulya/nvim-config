local M = {}
local icons = require('icons')

M.config = {
  ---@usage disable which-key completely [not recommended]
  setup = {
    delay = 1000,
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
    { '<leader>g', group = 'Git' },
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Fugitive' },
  },
}

M.setup = function()
  local wk = require('which-key')

  wk.setup(M.config.setup)
  wk.add(M.config.keys)
end

return M
