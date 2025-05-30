local nls = require('null-ls')
local U = require('lsp.utils')

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
  sources = {
    ----------------
    -- FORMATTING --
    ----------------
    -- fmt.trim_whitespace.with({
    --   filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
    -- }),
    -- NOTE:
    -- 1. both needs to be enabled to so prettier can apply eslint fixes
    -- 2. prettierd should come first to prevent occassional race condition
    fmt.prettierd,
    fmt.stylua,
    fmt.nixpkgs_fmt,
    fmt.shfmt.with({
      extra_args = { '-i', 4, '-ci', '-sr' },
    }),
    -----------------
    -- DIAGNOSTICS --
    -----------------
    -- dgn.shellcheck,
    -- dgn.flake8,
    ------------------
    -- CODE ACTIONS --
    ------------------
    -- cda.shellcheck,
  },

  on_attach = function(client, bufnr)
    U.fmt_on_save(client, bufnr)
    U.mappings(bufnr)
  end,
})
