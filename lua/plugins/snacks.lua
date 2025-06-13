local M = {}

local dashboard_custom_header4 = {
  '',
  '',
  '',
  '',
  '██╗░░██╗███████╗███╗░░██╗████████╗░█████╗░██╗',
  '██║░░██║██╔════╝████╗░██║╚══██╔══╝██╔══██╗██║',
  '███████║█████╗░░██╔██╗██║░░░██║░░░███████║██║',
  '██╔══██║██╔══╝░░██║╚████║░░░██║░░░██╔══██║██║',
  '██║░░██║███████╗██║░╚███║░░░██║░░░██║░░██║██║',
  '╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝',
  '',
  '',
  '',
  '',
  '',
}

local dashboard_custom_header18 = [[
⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂⣛⡓⣉⠉⠙⠻⢿⣿⣿⣟⣻⠿⣹⡏⣿⣿⣧⢸⣧⣿⣿⣨⡟⣿⣿⣿⣿
⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂⠸⣷⣹⣿⠄⠄⠄⠄⠘⢿⣿⣿⣯⣳⣿⣭⣽⢼⣿⣜⣿⣇⣷⡹⣿⣿⣿
⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔⠄⢻⣷⣿⡄⢈⠿⠇⢸⣿⣿⣿⣿⣿⣿⣟⠛⠲⢯⣿⣒⡾⣼⣷⡹⣿⣿
⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿⡄⢸⣿⣿⣷⣬⣽⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⢀⠉⠙⠛⠛⠳⠽⠿
⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢄⣹⡿⠃⠄⠄⣰⠎⡈
⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⣽⣖⣄⣴⣯⣾⢷
⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈⣧⠸⣿⣿⣿⣿⣿⣿⠯⠊⠙⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣾
⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈⣿⣦⠹⣿⣿⣿⣿⣿⠄⢀⣴⢾⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿
⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈⣿⣿⣇⢽⣿⣿⣿⡏⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⡿⣿⣛⣻⠿⣟⣼⣿⣿
⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈⣿⣿⣿⡎⣷⣽⠻⣇⣿⣿⣿⡿⣟⣵⣿⣟⣽⣾⣿⣿⣿⣿⢯⣾⣿⣿⣿
]]

--@type snacks.Config
M.opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = dashboard_custom_header18,
    },
    sections = {
      { section = 'header' },
      {
        icon = ' ',
        key = 'r',
        desc = 'Recent Files',
        action = ":lua Snacks.dashboard.pick('oldfiles')",
        padding = 1,
      },
      {
        icon = ' ',
        key = 'f',
        desc = 'Find File',
        action = ":lua Snacks.dashboard.pick('files')",
        padding = 1,
      },
      {
        icon = ' ',
        key = 'c',
        desc = 'Config',
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        padding = 1,
      },
      {
        icon = ' ',
        key = 'p',
        desc = 'Projects',
        action = ':Telescope projects',
        padding = 1,
      },
      {
        icon = '󰙈',
        desc = 'Notes',
        key = 'n',
        key_hl = 'group',
        action = ':Telescope find_files search_dirs=~/org',
        padding = 1,
      },

      { section = 'startup' },
    },
  },

  indent = { enabled = true },
  input = { enabled = false, prompt_pos = 'left' },
  notifier = { enabled = false },
  quickfile = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  words = { enabled = false },
  scope = { enabled = false },
}

M.keys = {
  {
    '<leader>.',
    function()
      Snacks.scratch()
    end,
    desc = 'Toggle Scratch Buffer',
  },
  {
    '<leader>S',
    function()
      Snacks.scratch.select()
    end,
    desc = 'Select Scratch Buffer',
  },
  {
    '<leader>n',
    function()
      Snacks.notifier.show_history()
    end,
    desc = 'Notification History',
  },
  {
    'Q',
    function()
      Snacks.bufdelete()
    end,
    desc = 'Delete Buffer',
  },
  {
    '<f2>',
    function()
      Snacks.rename.rename_file()
    end,
    desc = 'Rename File',
  },
  {
    '<leader>gB',
    function()
      Snacks.gitbrowse()
    end,
    desc = 'Git Browse',
    mode = { 'n', 'v' },
  },
  {
    '<leader>gb',
    function()
      Snacks.git.blame_line()
    end,
    desc = 'Git Blame Line',
  },
}

M.init = function()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      -- Create some toggle mappings
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
      Snacks.toggle
        .option('relativenumber', { name = 'Relative Number' })
        :map('<leader>uL')
      Snacks.toggle.diagnostics():map('<leader>ud')
      Snacks.toggle.line_number():map('<leader>ul')
      Snacks.toggle
        .option('conceallevel', {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
        })
        :map('<leader>uc')
      Snacks.toggle.treesitter():map('<leader>uT')
      Snacks.toggle
        .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
        :map('<leader>ub')
      Snacks.toggle.inlay_hints():map('<leader>uh')
      Snacks.toggle.indent():map('<leader>ug')
      Snacks.toggle.dim():map('<leader>uD')
    end,
  })
end

return M
