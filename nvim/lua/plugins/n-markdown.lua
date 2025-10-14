return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('render-markdown').setup({
        sign = { enabled = false },
        code = {
          border = 'thin',
          left_pad = 1,
          right_pad = 1,
          sign = false,
          style = 'language',
        },
        heading = {
          icons = { ' 󰼏 ', ' 󰎨 ', ' 󰼑 ', ' 󰎲 ', ' 󰼓 ', ' 󰎴 ' },
          border = false,
          render_modes = true, -- keep rendering while inserting
        },
        checkbox = {
          unchecked = { icon = '✘' },
          checked = { icon = '✔' },
          custom = {
            question = { raw = '[?]', rendered = '' },
            todo = { raw = '[>]', rendered = '󰦖' },
            canceled = { raw = '[-]', rendered = '', scope_highlight = '@text.strike' },
            important = { raw = '[!]', rendered = '' },
            favorite = { raw = '[~]', rendered = '' },
          },
        },
        pipe_table = {
          alignment_indicator = '─',
          border = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '│', '─' },
        },
        anti_conceal = {
          disabled_modes = { 'n' },
          ignore = {
            bullet = true, -- render bullet in insert mode
            head_border = true,
            head_background = true,
          },
        },
        -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
        win_options = { concealcursor = { rendered = 'nvc' } },
        completions = {
          blink = { enabled = true },
          lsp = { enabled = true },
        },
      })
    end,
  },
}
