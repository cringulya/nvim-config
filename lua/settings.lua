local g = vim.g
local o = vim.o

-- cmd('syntax on')
vim.api.nvim_command('filetype plugin indent on')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

o.relativenumber = true
o.colorcolumn = '81'

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 2

-- Better editor UI
o.number = true
o.cursorline = true
o.cmdheight = 0

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = false
o.smartindent = false
o.autoindent = true
o.wrap = true
o.textwidth = 80
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
o.foldmethod = 'indent'
o.foldlevelstart = 99
o.foldnestmax = 3
o.foldminlines = 1

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = '\\'
