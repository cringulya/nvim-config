local map = vim.keymap.set

local U = {}

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

---Common format-on-save for lsp servers that implements formatting
---@param client table
---@param buf integer
function U.fmt_on_save(client, buf)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({
          timeout_ms = 3000,
          buffer = buf,
        })
      end,
    })
  end
end

---Disable formatting for servers | Handled by null-ls
---@param client table
---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function U.disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = true
end

---Creates LSP mappings
---@param buf number
function U.mappings(buf)
  local opts = { buffer = buf }

  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(
    'n',
    '<leader>wa',
    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
    opts
  )
  map(
    'n',
    '<leader>wr',
    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
    opts
  )
  map(
    'n',
    '<leader>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
    opts
  )
  -- map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', 'Ï', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  vim.keymap.set('n', '<m-F>', function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  -- map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

return U
