return {
  'folke/flash.nvim',
  event = 'VeryLazy',
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
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[Flash]: Flash Jump" },
  },
}
