local wk = require('which-key')

require('gitsigns').setup({
  on_attach = function(buf)
    local gs = package.loaded.gitsigns
    local opts = { buffer = buf, expr = true, replace_keycodes = false }

    -- Navigation  map('n', ']c', "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", opts)
    -- map('n', '[c', "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", opts)

    -- Actions

    wk.add({
      { '<leader>gr', gs.reset_hunk, desc = 'Reset hunk' },
      { '<leader>gs', gs.stage_hunk, desc = 'Stage hunk' },
      { '<leader>gS', gs.stage_buffer, desc = 'Stage buffer' },
      { '<leader>gl', gs.blame_line, desc = 'Blame' },
      { '<leader>gp', gs.preview_hunk, desc = 'Preview Hunk' },
      { '<leader>gr', gs.reset_hunk, desc = 'Reset Hunk' },
      { '<leader>gR', gs.reset_buffer, desc = 'Reset Buffer' },
      { '<leader>gs', gs.stage_hunk, desc = 'Stage Hunk' },
      { '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', desc = 'Git Diff' },
      { '<leader>gj', '<cmd>Gitsigns next_hunk<cr>', desc = 'Next Hunk' },
      { '<leader>gk', '<cmd>Gitsigns prev_hunk<cr>', desc = 'Prev Hunk' },
    }, opts)
  end,
})
