return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    -- 'nvim-tree/nvim-web-devicons'
    'echasnovski/mini.icons',
  },
  config = function()
    local db = require('dashboard')
    db.setup({
      -- theme: hyper, doom
      theme = 'hyper',
      config = {
        week_header = { enable = true },
        packages = { enable = true }, -- show how many plugins neovim loaded
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = '@property',
            action = 'lua require("fzf-lua").files()',
            key = 'f',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'lua require("fzf-lua").files({cwd = "~/.config/nvim"})',
            key = 'd',
          },
        },
      },
    })
  end,
}
