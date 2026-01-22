return {
  'nvimdev/lspsaga.nvim',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('lspsaga').setup({
      ui = {
        border = 'single',
        code_action = '',
        actionfix = '',
        imp_sign = '󰳛 ',
      },
      lightbulb = {
        enable = true,
        sign = false, -- 设置成false 防止光标经过codeaction所在行之后的窗口抖动
      },
      code_action = {
        show_server_name = true,
        extend_gitsigns = true,
        keys = { quit = 'q', exec = '<CR>' },
      },
      symbol_in_winbar = { enable = true },
      outline = {
        -- win_position = 'right',
        layout = 'float', -- normal or float
        win_width = 50,
        max_height = 0.5,
        left_width = 0.3,
        keys = {
          toggle_or_jump = 'e',
          jump = 'o',
          quit = 'q',
        },
      },
      diagnostic = {
        extend_relatedInformation = true,
        show_layout = 'float',
        max_show_width = 0.7,
        max_width = 0.7,
        keys = {
          exec_action = 'o',
          quit = 'q',
          go_action = '<CR>',
          quit_in_show = { 'q', '<ESC>' },
        },
      },
      hover = {
        max_width = 0.7,
        max_height = 0.6,
        open_link = 'o', -- key for opening links
      },
    })
  end,
}
