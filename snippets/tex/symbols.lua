local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local env = {}
env.in_mathzone = function() -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
env.in_text = function()
  return not env.in_mathzone()
end
env.in_comment = function() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
env.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
env.in_equation = function() -- equation environment detection
  return env.in_env('equation')
end
env.in_itemize = function() -- itemize environment detection
  return env.in_env('itemize')
end
env.in_tikz = function() -- TikZ picture environment detection
  return env.in_env('tikzpicture')
end

return {
  s(
    { trig = ';d' },
    { t('\\cdot') },
    { condition = env.in_mathzone, show_condition = env.in_mathzone }
  ),

  s({ trig = 'mbb' }, { t('\\mathbb{'), i(1), t('}') }),

  s(
    { trig = ';ld' },
    { t('\\ldotp') },
    { condition = env.in_mathzone, show_condition = env.in_mathzone }
  ),

  s({ trig = ';e' }, { t('\\varepsilon') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';b' }, { t('\\beta') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';p' }, { t('\\varphi') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';del' }, { t('\\delta') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';D' }, { t('\\Delta') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';a' }, { t('\\alpha') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';l' }, { t('\\lambda') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),

  s({ trig = ';inf' }, { t('\\infty') }, {
    condition = env.in_mathzone,
    show_condition = env.in_mathzone,
  }),
}
