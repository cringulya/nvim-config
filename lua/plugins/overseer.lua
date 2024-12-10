M = {}

M.config = {
  stategy = {
    'toggleterm',
    use_shell = true,
  },
  templates = { 'builtin', 'cmake' },
}

M.setup = function()
  require('overseer').setup(M.config)
end

return M
