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
  s({ trig = 'ьь' }, fmta('$<>$', { i(1) }), {
    condition = env.in_text,
    show_condition = env.in_text,
  }),

  s({ trig = 'ее' }, fmta('\\texttt{<>}', { i(1) })),

  s({ trig = 'ше' }, fmta('\\item <>', { i(0) })),

  s(
    { trig = 'вь' },
    fmta(
      [[
      \[
        <>
      \]
      ]],
      { i(0) }
    ),
    {
      condition = env.in_text,
      show_condition = env.in_text,
    }
  ),
}
