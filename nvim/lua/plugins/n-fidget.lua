return {
  'j-hui/fidget.nvim',
  opts = {
    notification = {
      window = {
        winblend = 0,
        border = 'none',
      },
    },
    integration = {
      ['nvim-tree'] = {
        enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
      },
    },
  },
}
