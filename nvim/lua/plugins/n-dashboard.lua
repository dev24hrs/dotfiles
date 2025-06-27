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
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- project = {
        --   limit = 6,
        --   label = '',
        --   action = 'Telescope find_files cwd=',
        -- },
        shortcut = {
          {
            desc = '󰚰 Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u',
          },
          {
            desc = ' Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope find_files cwd=~/.config/nvim',
            key = 'd',
          },
        },
      },
    })
  end,
}
