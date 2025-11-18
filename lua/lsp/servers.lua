require('neodev').setup({})
local U = require('lsp.utils')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.supports_method('textDocument/documentSymbol') then
      local navic = require('nvim-navic')
      navic.attach(client, args.buf)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if
      not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting')
    then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            timeout_ms = 1000,
          })
        end,
      })
    end
    U.mappings(args.buf)
  end,
})

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
vim.lsp.enable('clangd', {
  init_options = {
    fallbackFlags = { '--std=c++23', '-DKEKIS' },
  },
  cmd = require('tasks.cmake_utils.cmake_utils').currentClangdArgs(),
  on_attach = function(client, buf)
    vim.keymap.set(
      'n',
      '<leader>lh',
      '<cmd>ClangdSwitchSourceHeader<cr>',
      { buffer = buf }
    )
  end,
  capabilities = capabilities,
})

vim.lsp.enable('ruff', {
  trace = 'messages',
  init_options = {
    settings = {
      logLevel = 'debug',
      lineLength = 80,
      quoteStyle = 'single',
      lint = {
        enable = true,
      },
    },
  },
})

-- Lua
vim.lsp.enable('lua_ls', {
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

vim.lsp.enable('pyright', {
  settings = {
    python = {
      analysis = {
        extraPaths = {
          '~/SBISPlatformSDK/SBISPlatformSDK_253200/etc/stubs/',
          '~/SBISPlatformSDK/SBISPlatformSDK_254100/etc/stubs/',
          '~/SBISPlatformSDK/SBISPlatformSDK_255100/etc/stubs/',
        }, -- your stubs directory
        typeCheckingMode = 'strict',
        autoImportCompletions = true,
      },
    },
  },
})

vim.lsp.enable('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.enable('tinymist', {
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
    formatterPrintWidth = 80,
    outputPath = '$root/$dir/build/$name',
  },
})

vim.lsp.enable('rust-analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
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
  'gopls',
  'ts_ls',
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
