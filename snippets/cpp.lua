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
  s({ trig = 'pdebug', dscr = 'ifdef block' }, {
    t({ '#ifdef KEKIS', 'cout << "====Debug====" << endl;', '' }),
    i(0),
    t({ '', 'cout << "=============" << endl;', '#endif' }),
  }),
  s({ trig = 'contest', dscr = 'contest template' }, {
    t({
      '#include <bits/stdc++.h>',
      '',
      'using namespace std;',
      '#define forn(i, n) for (int i = 0; i < n; ++i)',
      'typedef long long ll;',
      'typedef vector<int> vi;',
      'typedef pair<int, int> pi;',
      'typedef vector<ll> vll;',
      'typedef vector<vector<int>> vvi;',
      'typedef vector<vector<ll>> vvll;',
      '',
      'template <class T1, class T2>',
      'istream &operator>>(istream &is, pair<T1, T2> &p) {',
      '  is >> p.first >> p.second;',
      '  return is;',
      '}',
      '',
      'template <class T>',
      'istream &operator>>(istream &is, vector<T> &v) {',
      '  for (auto &i : v) {',
      '    is >> i;',
      '  }',
      '  return is;',
      '}',
      '',
      'int rand(int a, int b) {',
      '  static std::random_device dev;',
      '  static std::mt19937 rng(dev());',
      '  std::uniform_int_distribution<std::mt19937::result_type> dist(a, b);',
      '  return dist(rng);',
      '}',
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
