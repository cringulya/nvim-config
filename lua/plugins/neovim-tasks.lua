local Path = require('plenary.path')

require('tasks').setup({
  default_params = { -- Default module parameters with which `neovim.json` will be created.
    cmake = {
      cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
      build_dir = tostring(Path:new('{cwd}', 'build', '{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
      build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
      dap_name = 'lldb', -- DAP configuration name from `require('dap').configurations`. If there is no such configuration, a new one with this name as `type` will be created.
      args = { -- Task default arguments.
        configure = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1', '-GNinja' },
      },
    },
  },
  save_before_run = true, -- If true, all files will be saved before executing a task.
  params_file = 'neovim.json', -- JSON file to store module and task parameters.
  quickfix = {
    pos = 'bot', -- Default quickfix position.
    height = 12, -- Default height.
  },
  dap_open_command = function()
    return require('dap').repl.open()
  end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})

vim.api.nvim_create_autocmd({ 'Filetype' }, {
  pattern = { 'cpp', 'c', 'cmake' },
  callback = function()
    vim.keymap.set('n', '<leader>cg', '<CMD>Task start cmake configure<CR>')
    vim.keymap.set('n', '<leader>cb', '<CMD>Task start cmake build<CR>')
    vim.keymap.set('n', '<leader>cr', '<CMD>Task start cmake run<CR>')
    vim.keymap.set(
      'n',
      '<leader>ct',
      '<CMD>Task set_module_param cmake target<CR>'
    )
  end,
})
