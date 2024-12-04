-- Treesitter folds
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 89
vim.g.skip_ts_context_commentstring_module = true

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ']]', ts_repeat_move.repeat_last_move_next)
vim.keymap.set(
  { 'n', 'x', 'o' },
  '[[',
  ts_repeat_move.repeat_last_move_previous
)

require('nvim-treesitter.configs').setup({
  -- nvim-treesitter/nvim-treesitter (self config)
  auto_install = true,
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'dockerfile',
    'fish',
    'gitignore',
    'html',
    'java',
    'javascript',
    'json',
    'latex',
    'lua',
    'make',
    'markdown',
    'tsx',
    'vim',
    'python',
    'typescript',
    'hlsl',
  },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    disable = { 'latex' },
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "'v",
      -- NOTE: These are visual mode mappings
      node_incremental = "'v",
      node_decremental = "'V",
    },
  },
  -- nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['uc'] = '@comment.outer',

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --     python = "(function_definition) @function",
        --     cpp = "(function_definition) @function",
        --     c = "(function_definition) @function",
        --     java = "(method_declaration) @function",
        -- },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["'a"] = '@parameter.inner',
        ["'f"] = '@function.outer',
        ["'e"] = '@element',
      },
      swap_previous = {
        ["'A"] = '@parameter.inner',
        ["'F"] = '@function.outer',
        ["'E"] = '@element',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']a'] = '@parameter.outer',
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_next_end = {
        [']A'] = '@parameter.outer',
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[a'] = '@parameter.outer',
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
      goto_previous_end = {
        ['[A'] = '@parameter.outer',
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer',
      },
    },
  },
  -- windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    -- highlight_current_scope = { enable = false },
  },
  matchup = {
    enable = true,
  },
})
