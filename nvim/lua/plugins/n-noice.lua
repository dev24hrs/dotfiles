---@diagnostic disable: missing-fields
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup({
      -- lsp = {
      --   override = {
      --     ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      --     ['vim.lsp.util.stylize_markdown'] = true,
      --   },
      --   hover = {
      --     silent = true,
      --   },
      -- },
      lsp = {
        progress = { enabled = false },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
          ['vim.lsp.util.stylize_markdown'] = false,
          -- ["cmp.entry.get_documentation"] = true,
        },
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = 'notify',
        opts = {},
      },
      presets = {
        lsp_doc_border = false,
        long_message_to_split = true,
      },
      routes = {

        {
          filter = {
            event = 'msg_show',
            kind = '',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = 'search_count',
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
    vim.keymap.set('n', '<leader>sn', '<CMD>NoiceFzf<CR>', { desc = '[Notify]: Search notifications' })
  end,
}
