local M = {}

local config = require('plugins.lualine.config')

M.setup = function()
  local lualine = require('lualine')
  lualine.setup(config)
end

return M
