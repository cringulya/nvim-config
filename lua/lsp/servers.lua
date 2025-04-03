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

local function on_attach_formatting(client, buf)
  local symbols_supported =
    client.supports_method('textDocument/documentSymbol')
  if symbols_supported then
    navic.attach(client, buf)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
  U.mappings(buf)
  U.fmt_on_save(client, buf)
end

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
  on_attach_formatting(client, buf)
  U.disable_formatting(client)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = 'always',
  },
  float = {
    source = 'always',
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
    fallbackFlags = { '--std=c++23' },
  },
  cmd = {
    'clangd',
    '--header-insertion=never',
  },
  on_attach = function(client, buf)
    client.documentSignatureHelpProvider = false
    navic.attach(client, buf)
    U.mappings(buf)
    vim.keymap.set(
      'n',
      '<leader>lh',
      '<cmd>ClangdSwitchSourceHeader<cr>',
      { buffer = buf }
    )
    U.fmt_on_save(client, buf)
  end,
  capabilities = capabilities,
})

lsp.ruff.setup({
  trace = 'messages',
  init_options = {
    settings = {
      logLevel = 'debug',
    },
  },
  on_attach = function(client, buf)
    local symbols_supported =
      client.supports_method('textDocument/documentSymbol')
    if symbols_supported then
      navic.attach(client, buf)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
    require('lsp_signature').on_attach({
      hint_prefix = ' ',
    })
    U.mappings(buf)
    U.fmt_on_save(client, buf)
  end,
  flags = flags,
  capabilities = capabilities,
})

-- Lua
lsp.lua_ls.setup({
  on_attach = on_attach,
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

-- Angular
-- 1. install @angular/language-server globally
-- 2. install @angular/language-service inside project as dev dep
lsp.angularls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(client, buf)
    client.server_capabilities.renameProvider = false
    on_attach(client, buf)
  end,
})

lsp.tinymist.setup({
  on_attach = on_attach_formatting,
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
    formatterPrintWidth = 80,
    outputPath = '$root/$dir/build/$name',
  },
})

lsp.rust_analyzer.setup({
  on_attach = on_attach,
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

lsp.omnisharp.setup({
  cmd = {
    '/Users/artemson/.local/share/nvim/mason/bin/omnisharp-mono',
  },
  on_attach = on_attach,

  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = false,

  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
})

---List of the LSP server that don't need special configuration
local servers = {
  'ts_ls', -- Typescript
  'html', -- HTML
  'cssls', -- CSS
  'yamlls', -- YAML
  'cmake',
  'pyright',
  'texlab',
  'nil_ls',
  'dockerls',
  'marksman',
  'jdtls',
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end
