if vim.g.neovide then
  vim.opt.guifont = { 'Iosevka Nerd Font' }

  vim.g.neovide_refresh_rate = 60
  -- vim.g.neovide_fullscreen = 1
  vim.opt.linespace = 2

  -- Change scale
  vim.g.neovide_scale_factor = 1.5
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  vim.keymap.set('n', '<C-+>', function()
    change_scale_factor(1.20)
  end)
  vim.keymap.set('n', '<C-_>', function()
    change_scale_factor(1 / 1.20)
  end)

  vim.keymap.set('v', '<c-c>', '"+y') -- Copy
  vim.keymap.set('n', '<c-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<c-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<c-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<c-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.api.nvim_set_keymap(
    '',
    '<C-v>',
    '+p<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    '!',
    '<C-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    'v',
    '<C-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )

  if vim.fn.has('macunix') then
    vim.g.neovide_input_macos_alt_is_meta = false
    vim.g.neovide_input_use_logo = true -- enable use of the logo (cmd) key
    vim.keymap.set({ 'n', 'i', 'v' }, '<D-C-f>', function()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      print('Toggle fullscreen')
    end)
    vim.keymap.set('n', '<D-=>', function()
      change_scale_factor(1.20)
    end)
    vim.keymap.set('n', '<D-->', function()
      change_scale_factor(1 / 1.20)
    end)
    vim.keymap.set('v', '<D-c>', '"+y') -- Copy
    vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<c-r>+') -- Paste insert mode
    vim.api.nvim_set_keymap(
      '',
      '<D-v>',
      '+p<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      '!',
      '<D-v>',
      '<C-R>+',
      { noremap = true, silent = true }
    )
    vim.cmd([[ tnoremap <expr> <D-v> "<C-\><C-N>"+pi" ]])
  end
end
