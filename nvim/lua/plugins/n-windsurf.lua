return {
  'Exafunction/windsurf.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    require('codeium').setup({
      enable_cmp_source = false, -- set false to disable nvim-cmp source for blink.cmp
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = '<C-,>',
          clear = 'C-x',
          next = '<C-;>',
          prev = "<C-'>",
          accept_word = false,
          accept_line = false,
        },
        filetypes = {
          markdown = false,
        },
      },
    })
    -- change the suggestion virtual_text color
    vim.api.nvim_set_hl(0, 'CodeiumSuggestion', { fg = '#B0B0B0', italic = true })
  end,
}
