return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    config = function()
      require('render-markdown').setup({
        -- enabled = true,
        completions = { lsp = { enabled = true } },
        heading = { position = 'inline', icons = { '󰼏 ', '󰎨 ' }, sign = false },

        quote = { icon = '▯' },
        callout = { note = { quote_icon = '█' } },
        checkbox = {
          unchecked = { icon = '✘ ' },
          checked = { icon = '✔ ' },
          custom = { todo = { rendered = '◯ ' } },
        },
        code = { sign = false, style = 'language' },
        pipe_table = { preset = 'round' },
        bullet = { icons = { '-', '-' } },
        sign = { enabled = false },
      })
    end,
  },
}
