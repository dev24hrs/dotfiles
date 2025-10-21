return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufEnter', 'BufReadPost', 'BufNewFile' },
  config = function()
    require('colorizer').setup()
  end,
}
