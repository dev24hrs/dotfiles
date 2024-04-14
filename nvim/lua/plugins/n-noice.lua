---@diagnostic disable: missing-fields
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  -- enabled = false,
  config = function()
    require('noice').setup({
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },

        -- set blew to fix conficts with other plugins like lsp-saga/ls-signatuer-help,
        signature = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
      -- set for use Classic cmdline
      -- cmdline = {
      --   view = 'cmdline',
      --   format = {
      --     cmdline = false,
      --   },
      -- },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = { 'search_count' },
          },
          opts = { skip = true },
        },
        {
          view = 'split',
          filter = { event = 'msg_show', min_height = 20 },
        },
      },
    })
    require('notify').setup({
      render = 'wrapped-compact',
      background_colour = '#000000',
    })
  end,
}
