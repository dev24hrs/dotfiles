---@diagnostic disable: missing-fields
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  enabled = true,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('noice').setup({
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
        hover = {
          silent = true,
        },
      },
      presets = {
        lsp_doc_border = true,
        long_message_to_split = true,
      },
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
  end,
}
