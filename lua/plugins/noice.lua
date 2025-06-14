local M = {}

M.config = {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    hover = {
      enabled = true,
      silent = true,
      view = nil, -- or "cmdline", "virtualtext", etc.
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },

  cmdline = {
    view = 'cmdline',
  },
  routes = {
    {
      filter = {
        event = 'msg_show',
        kind = '',
        find = 'written',
      },
      opts = { skip = true },
    },
  },
}

M.setup = function()
  local wk = require('which-key')
  require('noice').setup(M.config)

  wk.add({
    {
      '<leader>h',
      '<cmd>nohlsearch<cr><cmd>NoiceDismiss<cr>',
      desc = 'No Highlight',
    },
    {
      '<leader>n',
      function()
        require('noice').cmd('history')
      end,
      desc = 'Noice Messages',
    },
  })
end

return M
