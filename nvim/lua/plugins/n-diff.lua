return {
  'nvim-mini/mini.diff',
  event = 'BufReadPost',
  version = '*',
  keys = {
    {
      '<leader>to',
      function()
        require('mini.diff').toggle_overlay(vim.api.nvim_get_current_buf())
      end,
      mode = 'n',
      desc = '[Mini.Diff] Toggle diff overlay',
    },
  },
  opts = {
    -- NOTE: Mappings are handled by gitsigns.
    mappings = {
      apply = '',
      reset = '',
      textobject = '',
      goto_first = '',
      goto_prev = '',
      goto_next = '',
      goto_last = '',
    },
  },
}
