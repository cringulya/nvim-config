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
      '#include <iostream>',
      '#include <algorithm>',
      '#include <vector>',
      '#include <map>',
      '#include <stack>',
      '#include <queue>',
      '#include <string>',
      '',
      'using namespace std;',
      'typedef long long ll;',
      '',
      'int main() {',
      '  ios_base::sync_with_stdio(0);',
      '  ',
    }),
    i(0),
    t({ '', '}' }),
  }),
}
