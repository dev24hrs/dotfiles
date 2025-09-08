---@diagnostic disable: undefined-doc-name
return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  opts = {
    -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
    floating_window_scaling_factor = 0.8,
  },
  keys = {
    {
      '<leader>e',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open [Y]azi at the current file',
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
