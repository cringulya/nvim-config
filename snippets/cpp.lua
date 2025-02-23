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

return {
  s({ trig = 'contest', dscr = 'contest template' }, {
    t({
      '#include <bits/stdc++.h>',
      '',
      'using namespace std;',
      'typedef long long ll;',
      '',
      'static const bool MULTITEST = ',
    }),
    i(1, 'false'),
    t({
      ';',
      '',
      'void go() {',
      '  ',
    }),
    i(0),
    t({
      '',
      '}',
      '',
      'int main() {',
      '  ios_base::sync_with_stdio(0);',
      '  if (MULTITEST) {',
      '    int n;',
      '    cin >> n;',
      '    for (int t = 0; t < n; ++t) {',
      '      go();',
      '    }',
      '  } else {',
      '    go();',
      '  }',
      '}',
    }),
  }),
}
