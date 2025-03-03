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

local tex = {}
tex.in_mathzone = function() -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end
tex.in_comment = function() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex.in_equation = function() -- equation environment detection
  return tex.in_env('equation')
end
tex.in_itemize = function() -- itemize environment detection
  return tex.in_env('itemize')
end
tex.in_tikz = function() -- TikZ picture environment detection
  return tex.in_env('tikzpicture')
end

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

table_node = function(args)
  local tabs = {}
  local count
  table = args[1][1]:gsub('%s', ''):gsub('|', '')
  count = table:len()
  for j = 1, count do
    local iNode
    iNode = i(j)
    tabs[2 * j - 1] = iNode
    if j ~= count then
      tabs[2 * j] = t(' & ')
    end
  end
  return sn(nil, tabs)
end

rec_table = function()
  return sn(nil, {
    c(1, {
      t({ '' }),
      sn(nil, {
        t({ '\\\\', '' }),
        d(1, table_node, { ai[1] }),
        d(2, rec_table, { ai[1] }),
      }),
    }),
  })
end

return {

  s('table', {
    t('\\begin{tabular}{'),
    i(1, '0'),
    t({ '}', '' }),
    d(2, table_node, { 1 }, {}),
    d(3, rec_table, { 1 }),
    t({ '', '\\end{tabular}' }),
  }),

  s(
    'ssu',
    { t('\\subsubsection*{'), i(1), t('}') },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    'su',
    { t('\\subsection*{'), i(1), t('}') },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),
  s(
    'sec',
    { t('\\section*{'), i(1), t('}') },
    { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    'tkz',
    fmta(
      [[
      \begin{figure}[h]
        \centering
        \begin{tikzpicture}[
            roundnode/.style={circle, draw=black!60, very thick,
                minimum size=5mm},
            node distance=15cm,
            auto
          ]
          <>
        \end{tikzpicture}
      \end{figure}
      ]],
      { i(0) }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    'code',
    fmta(
      [[
      \begin{lstlisting}[language=<>]
        <>
      \end{lstlisting}
      ]],
      { c(1, { i(nil), t('C++') }), i(2) }
    ),
    { condition = tex.in_text, show_condition = tex.in_text }
  ),

  s(
    { trig = 'preambule', dscr = 'preambule' },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      %! suppress = Makeatletter
      %! suppress = TooLargeSection
      %! suppress = MissingLabel

      \documentclass[10pt,fleqn,a4paper]{article}
      % Math and theorem environments
      \usepackage{amsmath, amsthm}  % Load first
      \usepackage{luacode}
      % Language and fonts
      \usepackage{fontspec}
      \usepackage{polyglossia}
      \setmainlanguage{russian}
      \setotherlanguage{english}
      % Fonts
      \usepackage{fontspec}
      \setmainfont{CMU Serif}
      \setmonofont{Iosevka Nerd Font Mono}
      \usepackage{unicode-math}
      \setmathfont{Latin Modern Math}

      % Theorem styles
      \theoremstyle{definition}
      \newtheorem{problem}{Задача}
      \newtheorem{definition}{Определение}
      \newtheorem{theorem}{Теорема}
      \newtheorem{corollary}{Следствие}
      % Code highlighting
      \usepackage{minted}
      \setminted{fontsize=\footnotesize, autogobble, breaklines, frame=single}
      % Graphics and TikZ
      \usepackage{tikz}
      \usetikzlibrary{arrows.meta, automata, positioning, graphs, calc}
      \usepackage{pgfplots}
      \pgfplotsset{compat=1.18}
      % Page layout
      \usepackage[a4paper, left=20mm, right=20mm, top=25mm, bottom=25mm]{geometry}
      \usepackage{fullpage}
      \usepackage{indentfirst}
      \usepackage{parskip}
      % Figures
      \usepackage{graphicx}
      \usepackage{float}
      \usepackage{caption, subcaption}
      % Hyperlinks
      \usepackage{hyperref}
      \hypersetup{
          colorlinks=true,
          linkcolor=blue,
          urlcolor=blue
      }
      % Graphics path
      \graphicspath{{images/}}

      % Proof environment fix
      \newenvironment{solution}
          {\begin{proof}[\textbf{Решение}]$ $\par\nobreak\ignorespaces}
          {\end{proof}}

      \newcommand{\F}{\mathbb{F}}
      \newcommand{\Z}{\mathbb{Z}}
      \newcommand{\N}{\mathbb{N}}
      \newcommand{\R}{\mathbb{R}}
      \renewcommand{\O}{\mathcal{O}}

      \newcommand{\Let}{%
        \mathord{\setbox0=\hbox{$\exists$}%
          \hbox{\kern 0.125\wd0%
             \vbox to \ht0{%
             \hrule width 0.75\wd0%
             \vfill%
             \hrule width 0.75\wd0}%
             \vrule height \ht0%
             \kern 0.125\wd0}%
        }%
      }

      \title{<>}
      \author{Сон Артём}
      \date{\luaexec{os.setlocale("ru_RU.UTF-8") tex.print(os.date('\%d \%B \%Y'))}}


      \begin{document}
      \maketitle

      <>

      \end{document}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = 'cpplstset', dscr = 'cpp lstset' },
    fmta( -- The snippet code actually looks like the equation environment it produces.
      [[
      \lstset{ %
        language=C++,                % the language of the code
        basicstyle=\footnotesize,           % the size of the fonts that are used for the code
        numbers=left,                   % where to put the line-numbers
        numberstyle=\tiny\color{gray},  % the style that is used for the line-numbers
        stepnumber=1,                   % the step between two line-numbers. If it's 1, each line
                                        % will be numbered
        numbersep=5pt,                  % how far the line-numbers are from the code
        backgroundcolor=\color{white},      % choose the background color. You must add \usepackage{color}
        showspaces=false,               % show spaces adding particular underscores
        showstringspaces=false,         % underline spaces within strings
        showtabs=true,                 % show tabs within strings adding particular underscores
        frame=single,                   % adds a frame around the code
        rulecolor=\color{black!10},        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
        tabsize=2,                      % sets default tabsize to 2 spaces
        captionpos=b,                   % sets the caption-position to bottom
        breaklines=true,                % sets automatic line breaking
        breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
        title=\lstname,                   % show the filename of files included with \lstinputlisting;
                                        % also try caption instead of title
        keywordstyle=\color{blue},          % keyword style
        commentstyle=\color{dkgreen},       % comment style
        stringstyle=\color{mauve},        % string literal style
        escapeinside={\%*}{*)},            % if you want to add LaTeX within your code
        morekeywords={done, to},              % if you want to add more keywords to the set
      %  deletekeywords={...}              % if you want to delete keywords from the given language
      }
      <>
      ]],
      { i(0) }
    )
  ),
}
