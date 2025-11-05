return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local db = require('dashboard')
    db.setup({
      -- theme: hyper, doom
      theme = 'hyper',
      config = {
        week_header = { enable = true },
        packages = { enable = true }, -- show how many plugins neovim loaded
        project = {
          enable = true,
          limit = 5,
          icon = ' ',
          label = '',
          action = function(path)
            -- Snacks.picker.files({ cwd = path })
            require('fzf-lua').files({ cwd = path })
          end,
        },
        shortcut = {
          { icon = '󰊳 ', desc = 'Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = '@property',
            action = function()
              -- Snacks.picker.files()
              require('fzf-lua').files()
            end,
            key = 'f',
          },
          {
            icon = ' ',
            desc = 'Dotfiles',
            group = 'Number',
            action = function()
              -- Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
              require('fzf-lua').files({ cwd = '~/.config/nvim' })
            end,
            key = 'd',
          },
        },
      },
    })
  end,
}
