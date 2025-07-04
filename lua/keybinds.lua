local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- -- Terminal
--
-- map('n', '<C-t>', '<cmd>split term<cr>i')

-- Move to the next/previous buffer
-- map('n', '<TAB>', '<CMD>bn<CR>')
-- map('n', '<s-TAB>', '<CMD>bp<CR>')
map({ 'n', 'v' }, 'Q', '<cmd>bd!<cr>')
map({ 'n', 'v' }, 'H', '0')
map({ 'n', 'v' }, 'L', '$')
map({ 'n', 'v' }, 'Р', '0')
map({ 'n', 'v' }, 'Д', '$')

-- Terminal to normal mode
map('t', '<ESC>', '<C-\\><C-n><CR>')

-- Maps this in tmux-navigator plugin
-- map('n', '<C-j>', '<C-w>j')
-- map('n', '<C-k>', '<C-w>k')
-- map('n', '<C-l>', '<C-w>l')
-- map('n', '<C-h>', '<C-w>h')
--
map('n', '<ESC>', '<CMD>Trouble quickfix close<CR><CMD>NvimTreeClose<CR>')
map('n', '<c-q>', '<cmd>Trouble quickfix toggle<cr>')

-- vim.cmd([[
-- function! ToggleQuickFix()
--     if empty(filter(getwininfo(), 'v:val.quickfix'))
--         copen
--     else
--         cclose
--     endif
-- endfunction
--
-- nnoremap <silent> <c-q> :call ToggleQuickFix()<CR>
-- ]])
