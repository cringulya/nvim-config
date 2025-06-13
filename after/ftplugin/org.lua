vim.opt_local.concealcursor = 'nvc'
vim.opt_local.conceallevel = 2
vim.opt_local.colorcolumn = '0'
vim.opt_local.number = false
vim.opt_local.relativenumber = false

Snacks.indent.disable()

vim.keymap.set(
  'i',
  '<S-CR>',
  '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>',
  { silent = true, buffer = true }
)
