require('neodev').setup({})
local lsp = require('lspconfig')
local U = require('lsp.utils')

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local navic = require('nvim-navic')

local function on_attach(client, buf)
  local symbols_supported =
    client.supports_method('textDocument/documentSymbol')
  if symbols_supported then
    navic.attach(client, buf)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
  U.mappings(buf)
end

local function on_attach_fmt_save(client, buf)
  on_attach(client, buf)
  U.fmt_on_save(client, buf)
end

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach_no_fmt(client, buf)
  on_attach(client, buf)
  U.disable_formatting(client)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.ERROR)

-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = true,
  },
  float = {
    source = true,
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        return string.format('%s [%s]', d.message, code):gsub('1. ', '')
      end
      return d.message
    end,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  focusable = true,
  style = 'minimal',
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
  })

local ls = require('luasnip')
local s = ls.snippet
local r = ls.restore_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

-- clangd
lsp.clangd.setup({
  init_options = {
    fallbackFlags = { '--std=c++23', '-DKEKIS' },
  },
  cmd = require('tasks.cmake_utils.cmake_utils').currentClangdArgs(),
  on_attach = function(client, buf)
    on_attach_no_fmt(client, buf)
    vim.keymap.set(
      'n',
      '<leader>lh',
      '<cmd>ClangdSwitchSourceHeader<cr>',
      { buffer = buf }
    )
  end,
  capabilities = capabilities,
})

lsp.ruff.setup({
  trace = 'messages',
  init_options = {
    settings = {
      logLevel = 'debug',
      lineLength = 120,
    },
  },
  on_attach = on_attach_fmt_save,
  flags = flags,
  capabilities = capabilities,
})

-- Lua
lsp.lua_ls.setup({
  on_attach = on_attach_no_fmt,
  flags = flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        enable = true,
        showWord = 'Disable',
        -- keywordSnippet = 'Disable',
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing
      -- a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lsp.jsonls.setup({
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

lsp.tinymist.setup({
  on_attach = on_attach_fmt_save,
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
    formatterPrintWidth = 80,
    outputPath = '$root/$dir/build/$name',
  },
})

lsp.rust_analyzer.setup({
  on_attach = on_attach_fmt_save,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

---List of the LSP server that don't need special configuration
local servers = {
  'html', -- HTML
  'cssls', -- CSS
  'yamlls', -- YAML
  'cmake',
  'texlab',
  'nil_ls',
  'dockerls',
  'marksman',
  'jdtls',
}

local servers_no_format = {
  'ts_ls', -- Typescript
  'pyright',
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

local conf_no_format = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach_no_fmt,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end

for _, server in ipairs(servers_no_format) do
  lsp[server].setup(conf_no_format)
end
