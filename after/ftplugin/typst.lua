vim.api.nvim_create_user_command('OpenPdf', function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match('%.typ$') then
    local cur_dir = vim.fn.fnamemodify(filepath, ':h')
    local base = vim.fn.fnamemodify(filepath, ':t:r')
    local pdf_path = cur_dir .. '/build/' .. base .. '.pdf'
    if vim.fn.filereadable(pdf_path) == 1 then
      vim.fn.jobstart({ 'zathura', pdf_path }, { detach = true })
    else
      print('PDF not found: ' .. pdf_path)
    end
  end
end, {})
