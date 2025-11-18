local dap = require('dap')

require('nvim-dap-virtual-text').setup()
require('dap-python').setup('/opt/python3.11/bin/python3.11')

dap.adapters.lldb = {
  type = 'executable',
  command = vim.fn.stdpath('data')
    .. '/mason/packages/codelldb/extension/adapter/codelldb',
  name = 'lldb',
}

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input(
        'Path to executable: ',
        vim.fn.getcwd() .. '/',
        'file'
      )
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = true,
  },
  {
    name = 'Launch executor-core unit-tests',
    type = 'lldb',
    request = 'launch',
    program = vim.fn.getcwd() .. '/build/relwithdebinfo/bin/test_executor_core',
    cwd = vim.fn.getcwd()
      .. '/build/relwithdebinfo/tests/executor-core-tests/run',
  },
  {
    name = 'Select and attach to process',
    type = 'lldb',
    request = 'attach',
    program = function()
      return vim.fn.input(
        'Path to executable: ',
        vim.fn.getcwd() .. '/',
        'file'
      )
    end,
    pid = function()
      local name = vim.fn.input('Executable name (filter): ')
      return require('dap.utils').pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}',
  },
  {
    name = 'Launch Python with C++',
    type = 'lldb', -- или "gdb"
    request = 'launch',
    program = '/opt/python3.11/bin/python3.11',
    args = {
      'py_tests_runner.py',
      '/home/ai.son/work/local_stand/Project/aps_executor/tests/ExecutorTestSuite/src',
      '--driver',
      'unittest',
      '--err_to_stderr',
      '--package_name',
      'ExecutorTestSuite',
    },
    cwd = '${workspaceFolder}/build/relwithdebinfo/tests/ExecutorTestSuite/run',
    stopAtBeginningOfMainSubprogram = true,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<F11>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<F12>', function()
  require('dap').step_out()
end)
vim.keymap.set('n', '<Leader>b', function()
  require('dap').toggle_breakpoint()
end)
vim.keymap.set('n', '<Leader>B', function()
  require('dap').set_breakpoint()
end)
vim.keymap.set('n', '<Leader>lp', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
vim.keymap.set('n', '<Leader>dr', function()
  require('dap').repl.open()
end)
vim.keymap.set('n', '<Leader>dl', function()
  require('dap').run_last()
end)

local dapui = require('dapui')
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
