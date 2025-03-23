local ls = require('luasnip')
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local ai = require('luasnip.nodes.absolute_indexer')
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require('luasnip.util.types')
local conds = require('luasnip.extras.conditions')

return {
  s({ trig = 'mm' }, fmta('$<>$', { i(1) }), {}),
  s({ trig = 'ьь' }, fmta('$<>$', { i(1) }), {}),
  s({ trig = '^(.*)__', regTrig = true, snippetType = 'autosnippet' }, {
    f(function(_, snip)
      return snip.captures[1]
    end, {}),
    t('_('),
    i(1),
    t(')'),
  }),

  s({ trig = '^(.*)^^', regTrig = true, snippetType = 'autosnippet' }, {
    f(function(_, snip)
      return snip.captures[1]
    end, {}),
    t('^('),
    i(1),
    t(')'),
  }),
}
