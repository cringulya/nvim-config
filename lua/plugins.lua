local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = 'night',
      on_colors = function(colors)
        colors.border = '#FFA500'
      end,
    },
  },

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      contrast = 'hard',
      transparent_mode = true,
    },
  },

  { 'numToStr/Sakura.nvim', priority = 1000 },

  { 'folke/neodev.nvim', lazy = true },

  {
    'folke/which-key.nvim',
    event = 'BufWinEnter',
    config = function()
      require('plugins.which-key').setup()
    end,
  },

  {
    'nvim-lua/plenary.nvim',
    lazy = true,
    dependencies = {
      {
        'CRAG666/code_runner.nvim',
        event = 'BufRead',
        config = function()
          require('plugins.code_runner')
        end,
      },
    },
  },

  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.dashboard-nvim')
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    lazy = true,
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    'nvim-neorg/neorg',
    dependencies = { 'luarocks.nvim' },
    lazy = false,
    -- put any other flags you wanted to pass to lazy here!
    config = function()
      require('neorg').setup()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.lualine').setup()
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    event = 'VimEnter',
    config = function()
      require('plugins.nvim-tree')
    end,
  },

  {
    'karb94/neoscroll.nvim',
    event = 'BufEnter',
    opts = { hide_cursor = false },
  },

  --------------------------
  -- Editor UI Niceties --
  --------------------------

  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },

  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   event = 'BufRead',
  --   main = 'ibl',
  --   config = function()
  --     require('ibl').setup()
  --   end,
  -- },
  --
  {
    'folke/twilight.nvim',
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { 'Normal', '#ffffff' },
        term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 10, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        'function',
        'method',
        'table',
        'if_statement',
      },
      exclude = {}, -- exclude these filetypes
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'CursorHold',
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.gitsigns')
    end,
  },

  {
    'tpope/vim-fugitive',
    event = 'BufRead',
  },

  {
    'rhysd/git-messenger.vim',
    event = 'BufRead',
    config = function()
      require('plugins.git-messenger')
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('Comment').setup({
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook(),
      })
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        enable_autocmd = false,
      },
    },
  },

  { 'LudoPinelli/comment-box.nvim' },

  {
    'tpope/vim-repeat',
    event = 'BufRead',
    dependencies = {
      {
        'tpope/vim-surround',
        event = 'BufRead',
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },

      { 'nvim-telescope/telescope-symbols.nvim' },

      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('plugins.project')
          require('telescope').load_extension('projects')
        end,
      },
    },
  },

  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
      },
    },
  },

  {
    'SmiteshP/nvim-navic',
    event = 'BufRead',
    config = function()
      require('plugins.breadcrumps').setup()
    end,
  },

  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    lazy = true,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      require('lsp.servers')
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function()
      require('lsp.null-ls')
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'BufRead',
    config = function()
      require('lsp.nvim-cmp')
    end,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('lsp.luasnip')
        end,
        dependencies = {
          { 'rafamadriz/friendly-snippets' },
        },
      },
      {
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        config = function()
          require('plugins.pairs')
        end,
      },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- SchemaStore
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },

  ------------------
  -------CODE------
  ------------------

  {
    'AckslD/swenv.nvim',
    ft = 'py',
    opts = {
      -- Should return a list of tables with a `name` and a `path` entry each.
      -- Gets the argument `venvs_path` set below.
      -- By default just lists the entries in `venvs_path`.
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,
      -- Path passed to `get_venvs`.
      venvs_path = vim.fn.expand('~/.virtualenvs'),
      -- Something to do after setting an environment
      post_set_venv = function()
        vim.cmd([[
          :LspRestart<cr>
          ]])
      end,
    },
  },

  { 'mfussenegger/nvim-dap', event = 'VeryLazy' },

  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {
      library = { plugins = { 'nvim-dap-ui' }, types = true },
    },
  },

  {
    'Shatur/neovim-tasks',
    ft = { 'cpp', 'cmake' },
    config = function()
      require('plugins.neovim-tasks')
    end,
  },

  { 'ianding1/leetcode.vim', event = 'VeryLazy' },

  {
    'andymass/vim-matchup',
    event = 'BufRead',
    config = function()
      -- vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', '<plug>(matchup-%)')
      -- vim.keymap.set({ 'x', 'o' }, 'i<tab>', '<plug>(matchup-i%)')
      -- vim.keymap.set({ 'x', 'o' }, 'o<tab>', '<plug>(matchup-o%)')
      vim.g.matchup_override_vimtex = 1
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'CursorHold',
    config = function()
      require('plugins.bufferline')
    end,
    branch = 'main',
  },

  {
    'RRethy/vim-illuminate',
    event = 'BufEnter',
    config = function()
      require('plugins.illuminate')
    end,
  },

  {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
      vim.g.vimtex_compiler_latexmk_engines = { _ = '-lualatex' }
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = {
        out_dir = './build/',
      }
    end,
  },

  -----------------------------------
  -- Treesitter: Better Highlights --
  -----------------------------------

  {
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'BufEnter',
      build = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
      dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'nvim-treesitter/nvim-treesitter-refactor' },
        { 'windwp/nvim-ts-autotag' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
      },
    },
  },
})
