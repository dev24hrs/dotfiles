return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-/>]],
      shading_factor = '1',
      direction = 'horizontal',
      size = 15,
      -- direction = 'float',
      -- size = 20,
      -- float_opts = {
      --   border = 'single',
      -- },
    })
  end,
}
