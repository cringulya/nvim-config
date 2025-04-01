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
  s(
    { trig = 'dm' },
    fmta(
      [[
      $
        <>
      $
      ]],
      { i(1) }
    ),
    {}
  ),
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

  s(
    { trig = 'preambule', dscr = 'preambule' },
    fmta(
      [[
      #let conf(title: "", author: "Сон Артём", show_info: true, body) = {
        set page(
          paper: "a4",
          numbering: "1",
        )
        set document(author: author, title: title)
        set par(
          spacing: 0.65em,
          justify: true,
        )
        set text(11pt, font: "New Computer Modern", lang: "ru")

        show raw: text.with(font: "Iosevka NFM", size: 11pt)
        show heading: set block(above: 1.4em, below: 1em)

        if show_info {
          align(center)[ #block(text(20pt, title)) ]
          pad(
            top: 1em,
            align(center, text(size: 13pt, author)),
          )
          pad(
            top: 1em,
            bottom: 1em,
            align(center, text(size: 13pt, datetime.today().display("[day].[month].[year]"))),
          )
        }

        set par(justify: true)
        body
      }

      #let question_counter = counter("question_counter")
      #let part_counter = counter("part_counter")
      #let disp_question_counter = true

      #let problem(title, body) = {
        question_counter.step()
        move(line(length: 100%))
        show: text.with(weight: "bold")
        if disp_question_counter [
          #context question_counter.display("1. ")
        ]
        title
        move(line(length: 100%))

        show: text.with(weight: "regular")
        body

        part_counter.update(0)
      }

      #let part(body) = {
        part_counter.step()
        block[#{
            show: text.with(weight: "bold")
            context part_counter.display("(a)")
            show: text.with(weight: "regular")
            body
          }]
      }

      #let solution(body) = {
        block[#{
            show: text.with(weight: "semibold")
            emph([Решение: #parbreak()])
            show: text.with(weight: "regular")
            body
            [#v(0.1em)#h(1fr)$square$]
          }]
      }

      #let indented(body) = pad(
        left: .2in,
        body,
      )
      ]],
      {}
    )
  ),
}
