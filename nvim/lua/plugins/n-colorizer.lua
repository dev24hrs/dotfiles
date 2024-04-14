return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      require('colorizer').setup({
        '*', -- Highlight all files, but customize some others.
        css = { RRGGBBAA = true, rgb_fn = true, hsl_fn = true }, -- Enable parsing rgb(...) functions in css.
      }),
    })
  end,
}
