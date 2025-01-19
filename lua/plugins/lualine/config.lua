local colors = require('plugins.lualine.colors')

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  theme = {
    -- We are going to use lualine_c an lualine_x as left and
    -- right section. Both are highlighted by c theme .  So we
    -- are just setting default looks o statusline
    normal = { c = { fg = colors.fg, bg = colors.base } },
    inactive = { c = { fg = colors.fg, bg = colors.base } },
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { left = 1, right = 1 },
})

ins_left({
  'filename',
  cond = conditions.buffer_not_empty,
  color = { gui = 'bold' },
})

ins_left({ 'location' })

ins_left({
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
})

ins_right({
  function()
    local recording_register = vim.fn.reg_recording()
    if recording_register ~= '' then
      return 'recording @' .. recording_register
    end
    return ''
  end,
  cond = function()
    return vim.fn.reg_recording() ~= ''
  end,
  color = { fg = colors.violet },
})

ins_right({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.cyan },
  },
  padding = { right = 1 },
})
ins_right({
  -- Lsp server name .
  function()
    local function list_registered_names(filetype)
      local s = require('null-ls.sources')
      local available_sources = s.get_available(filetype)
      local registered = {}
      for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
          registered[method] = registered[method] or {}
          table.insert(registered[method], source.name)
        end
      end
      return registered
    end

    local function list_registered_formaters(filetype)
      local method = require('null-ls').methods.FORMATTING
      local registered_providers = list_registered_names(filetype)
      return registered_providers[method] or {}
    end

    local function list_registered_linters(filetype)
      local null_ls = require('null-ls')
      local alternative_methods = {
        null_ls.methods.DIAGNOSTICS,
        null_ls.methods.DIAGNOSTICS_ON_OPEN,
        null_ls.methods.DIAGNOSTICS_ON_SAVE,
      }
      local registered_providers = list_registered_names(filetype)
      local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
        return registered_providers[m] or {}
      end, alternative_methods))

      return providers_for_methods
    end
    msg = msg or ''
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == 'boolean' or #msg == 0 then
        return ''
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local copilot_active = false

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= 'null-ls' and client.name ~= 'copilot' then
        table.insert(buf_client_names, client.name)
      end

      if client.name == 'copilot' then
        copilot_active = true
      end
    end

    -- add formatter
    local supported_formatters = list_registered_formaters(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local supported_linters = list_registered_linters(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    local unique_client_names = vim.fn.uniq(buf_client_names)

    local language_servers = '['
      .. table.concat(unique_client_names, ', ')
      .. ']'

    return language_servers
  end,
  icon = '',
  color = { gui = 'bold' },
})

return config
