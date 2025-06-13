local M = {}

local actions = require('telescope.actions')
local lactions = require('telescope.actions.layout')
local finders = require('telescope.builtin')

M.opts = {
  defaults = {
    prompt_prefix = ' ❯ ',
    initial_mode = 'insert',
    sorting_strategy = 'ascending',
    results_title = '',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
        ['<C-s>'] = actions.send_selected_to_qflist,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-h>'] = lactions.toggle_preview,
      },
    },
  },
  pickers = {
    buffers = {
      theme = 'ivy',
      layout_strategy = 'bottom_pane',
      sort_mru = true,
      sort_lastused = true,
      ignore_current_buffer = true,
      previewer = true,
      prompt_title = false,
      layout_config = {
        height = 0.5,
      },
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- "smart_case" | "ignore_case" | "respect_case"
    },
  },
}

local Telescope = setmetatable({}, {
  __index = function(_, k)
    if vim.bo.filetype == 'NvimTree' then
      vim.cmd.wincmd('l')
    end
    return finders[k]
  end,
})

M.setup = function()
  require('telescope').setup(M.opts)

  local wk = require('which-key')
  wk.add({
    {
      '<leader>p',
      '<cmd>Telescope projects<cr>',
      desc = 'projects',
    },
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
    {
      '<leader>go',
      '<cmd>Telescope git_status<cr>',
      desc = 'Git status',
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
  })
end

return M
