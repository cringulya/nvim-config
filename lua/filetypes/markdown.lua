vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.formatoptions = 'tcqj'
    vim.opt_local.concealcursor = 'nvci'
    vim.opt_local.conceallevel = 2
    vim.opt_local.colorcolumn = '0'
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    Snacks.indent.disable()
  end,
})
