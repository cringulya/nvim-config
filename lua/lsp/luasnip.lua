local types = require('luasnip.util.types')

require('luasnip').setup({
  enable_autosnippets = true,
  cut_selection_keys = '<Tab>',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '●', 'DiffAdd' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '●', 'DiffDelete' } },
      },
    },
  },
})

require('luasnip.loaders.from_lua').load({
  paths = '~/.config/nvim/snippets',
})

-- Allow jsx and tsx to use js snippets
require('luasnip').filetype_extend(
  'javascript',
  { 'javascriptreact', 'typescriptreact' }
)

-- Mappins to move around inside snippets
vim.keymap.set({ 'i' }, '<c-u>', require('luasnip.extras.select_choice'))
