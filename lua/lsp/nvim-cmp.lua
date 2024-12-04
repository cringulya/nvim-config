local cmp = require('cmp')

local icons = require('icons')
local aliases = {
  nvim_lsp = 'lsp',
}

local ls = require('luasnip')

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping(function(fallback)
      if not cmp.visible() then
        if ls.choice_active() then
          ls.change_choice(1)
        else
          cmp.complete()
        end
      end
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    end, { 'i', 's' }),

    ['<C-p>'] = cmp.mapping(function(fallback)
      if not cmp.visible() then
        if ls.choice_active() then
          ls.change_choice(-1)
        else
          cmp.complete()
        end
      end
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    end, { 'i', 's' }),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),

    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      elseif ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local line = vim.api.nvim_get_current_line()
      if line:match('^%s*$') then
        fallback()
      elseif cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 10 },
    { name = 'luasnip', max_item_count = 10 },
    { name = 'path', max_item_count = 10 },
    { name = 'buffer', max_item_count = 10 },
  }),

  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, item)
      -- Kind icons
      -- item.kind = icons.kind[item.kind]
      -- Source
      item.menu =
        string.format('[%s]', aliases[entry.source.name] or entry.source.name)
      return item
    end,
  },
})
