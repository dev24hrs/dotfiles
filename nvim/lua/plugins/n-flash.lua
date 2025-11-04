return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    label = {
      rainbow = {
        enabled = true,
        shade = 1,
      },
    },
    modes = {
      char = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      'f',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = '[Flash]: Flash Jump',
    },
    {
      't',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
  },
}
