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
  s({ trig = '^(.*)__', regTrig = true, snippetType = 'autosnippet' }, {
    f(function(_, snip)
      return snip.captures[1]
    end, {}),
    t('_{'),
    i(1),
    t('}'),
  }, { condition = env.in_mathzone, show_condition = env.in_mathzone }),

  s({ trig = '^(.*)^^', regTrig = true, snippetType = 'autosnippet' }, {
    f(function(_, snip)
      return snip.captures[1]
    end, {}),
    t('^{'),
    i(1),
    t('}'),
  }, { condition = env.in_mathzone, show_condition = env.in_mathzone }),

  s(
    { trig = 'int' },
    fmta('\\int\\limits_{<>}^{<>} <>', { i(1), i(2), i(0) }),
    {
      condition = env.in_mathzone,
      show_condition = env.in_mathzone,
    }
  ),

  s({ trig = 'mm' }, fmta('$<>$', { i(1) }), {
    condition = env.in_text,
    show_condition = env.in_text,
  }),

  s(
    { trig = 'dm' },
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

  s(
    { trig = 'ff' },
    fmta('\\frac{<>}{<>}', {
      i(1),
      i(2),
    }),
    {
      condition = env.in_mathzone,
      show_condition = env.in_mathzone,
    }
  ),

  s(
    { trig = 'it' },
    fmta(
      [[
      \item <>
      ]],
      { i(0) },
      {
        condition = env.in_itemize,
        show_condition = env.in_itemize,
      }
    )
  ),

  s(
    { trig = 'itz' },
    fmta(
      [[
    \begin{itemize}
      \item <>
    \end{itemize}
    <>
    ]],
      { i(1), i(0) },
      {
        condition = env.in_mathzone,
        show_condition = env.in_mathzone,
      }
    )
  ),

  s(
    { trig = 'enum' },
    fmta(
      [[
    \begin{enumerate}
      \item <>
    \end{enumerate}
    <>
    ]],
      { i(1), i(0) },
      {
        condition = env.in_mathzone,
        show_condition = env.in_mathzone,
      }
    )
  ),

  s(
    { trig = 'lim' },
    fmta('\\lim_{<>} <>', {
      i(1),
      i(0),
    }),
    {
      condition = env.in_mathzone,
      show_condition = env.in_mathzone,
    }
  ),

  s(
    { trig = 'tt', dscr = "Expands 'tt' into '\texttt{}'" },
    fmta('\\texttt{<>}', { i(1) })
  ),

  s(
    { trig = 't', dscr = "Expands 't' into '\text{}'" },
    fmta('\\text{<>}', { i(1) })
  ),

  s(
    { trig = 'impl' },
    fmta('\\implies<>', {
      i(0),
    }),
    {
      condition = env.in_mathzone,
      show_condition = env.in_mathzone,
    }
  ),

  s(
    { trig = 'to' },
    fmta('\\to<>', {
      i(0),
    }),
    {
      condition = env.in_mathzone,
      show_condition = env.in_mathzone,
    }
  ),

  s(
    { trig = 'dd' },
    fmta('\\draw [<>] ', {
      i(1, 'params'),
    }),
    { condition = env.in_tikz, show_condition = env.in_tikz }
  ),

  s(
    { trig = 'eq', dscr = 'A LaTeX equation environment' },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{equation*}
        <>
      \end{equation*}
      ]],
      -- The insert node is placed in the <> angle brackets
      { i(0) },
      { condition = env.in_text, show_condition = env.in_text }
    )
  ),

  s(
    { trig = 'fla', dscr = 'A LaTeX flalign environment' },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \begin{flalign*}
        <>
      \end{flalign*}
      ]],
      -- The insert node is placed in the <> angle brackets
      { i(0) },
      { condition = env.in_text, show_condition = env.in_text }
    )
  ),
}
