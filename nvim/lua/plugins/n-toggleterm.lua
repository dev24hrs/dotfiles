return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-/>]],
      shading_factor = '1',
      -- direction = 'horizontal',
      direction = 'float',
      size = 15,
      float_opts = {
        border = 'single',
      },
    })
  end,
}
