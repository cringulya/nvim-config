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
      '#include <algorithm>',
      '#include <climits>',
      '#include <iostream>',
      '#include <map>',
      '#include <queue>',
      '#include <random>',
      '#include <set>',
      '#include <stack>',
      '#include <string>',
      '#include <vector>',
      '',
      'using namespace std;',
      '#define forn(i, n) for (int i = 0; i < n; ++i)',
      '#define fi first',
      '#define se second',
      '#ifdef KEKIS',
      '#define debug(...)                                                             \\',
      '  [](auto... a) { ((cout << a << \' \'), ...) << endl; }(#__VA_ARGS__, ":",      \\',
      '                                                       __VA_ARGS__)',
      '#define debugv(v)                                                              \\',
      '  do {                                                                         \\',
      '    cout << #v << " : {";                                                      \\',
      '    for (size_t izxc = 0; izxc < v.size(); ++izxc) {                           \\',
      '      cout << v[izxc];                                                         \\',
      '      if (izxc + 1 != v.size())                                                \\',
      '        cout << ",";                                                           \\',
      '    }                                                                          \\',
      '    cout << "}" << endl;                                                       \\',
      '  } while (0)',
      '#else',
      '#define debug(...)',
      '#define debugv(v)',
      '#endif',
      'typedef long long ll;',
      'typedef vector<int> vi;',
      'typedef vector<double> vd;',
      'typedef vector<ll> vll;',
      'typedef pair<int, int> pii;',
      'typedef vector<vector<int>> vvi;',
      'typedef vector<vector<double>> vvd;',
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
      '  cin.tie(0);',
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
