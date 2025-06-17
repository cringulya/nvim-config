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

  { 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
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

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        highlight_groups = {
          TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
          TelescopeNormal = { bg = 'none' },
          TelescopePromptNormal = { bg = 'base' },
          TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
          TelescopeSelection = { fg = 'text', bg = 'base' },
          TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
        },
      })
    end,
  },

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
    'nativerv/cyrillic.nvim',
    event = { 'VeryLazy' },
    config = function()
      require('cyrillic').setup({
        no_cyrillic_abbrev = false, -- default
      })
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
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require('render-markdown').setup({
        file_types = { 'markdown', 'quarto' },
        anti_conceal = { enabled = false },
        win_options = {
          concealcursor = {
            rendered = 'nci',
          },
        },
      })
    end,
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
    opts = {
      rocks = { 'magick' },
    },
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

  -- {
  --   'folke/snacks.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = require('plugins.snacks').opts,
  --   keys = require('plugins.snacks').keys,
  --   init = require('plugins.snacks').init,
  -- },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.noice').setup()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  { 'stevearc/dressing.nvim', event = 'VeryLazy' },

  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },

  {
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
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
        enable_autocmd = true,
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
      require('plugins.telescope').setup()
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
    'nvimtools/none-ls.nvim',
    event = 'BufRead',
    config = function()
      require('lsp.none-ls')
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('lsp.nvim-cmp')
    end,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        config = function()
          require('lsp.luasnip')
        end,
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

  { 'folke/trouble.nvim', opts = {}, cmd = 'Trouble' },

  -- SchemaStore
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },

  ------------------
  -------CODE------
  ------------------

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
  },

  {
    'stevearc/overseer.nvim',
    config = function()
      require('plugins.overseer').setup()
    end,
    dependencies = {

      { 'akinsho/toggleterm.nvim', version = '*', config = true },
    },
  },

  {
    'mrcjkb/haskell-tools.nvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      require('plugins.haskell').setup()
    end,
  },

  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    config = true,
    init = function()
      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {}, -- We added this line!
          ['core.export'] = {},
          ['core.completion'] = {},
          ['core.latex.renderer'] = {},
        },
      })
    end,
  },

  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('plugins.orgmode').setup()
    end,
    dependencies = { 'akinsho/org-bullets.nvim' },
  },

  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    config = function()
      require('plugins.dap')
    end,
  },

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
      vim.g.vimtex_compiler_latexmk_engines = { _ = '-pdflatex -shell-escape' }
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = {
        out_dir = './build/',
      }
    end,
  },

  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
      debug = true,
      dependencies_bin = {
        ['tinymist'] = 'tinymist',
      },
      -- open_cmd = 'zathura %s',
    }, -- lazy.nvim will implicitly calls `setup {}`
  },

  {
    '3rd/image.nvim',
    opts = {},
  },

  { 'lukas-reineke/virt-column.nvim', opts = {} },

  -----------------------------------
  -- Treesitter: Better Highlights --
  -----------------------------------

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufEnter',
    build = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'windwp/nvim-ts-autotag' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
    },
  },
})
