return {
  'stevearc/aerial.nvim',
  event = 'LspAttach',
  opts = {
    attach_mode = 'global',
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    disable_max_lines = 5000,
    filter_kind = false,
    highlight_on_hover = true,
    ignore = { filetypes = { 'gomod' } },
    layout = { min_width = 15, position = 'right', width = 30 },
    show_guides = true,
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>o',
      '<cmd>AerialToggle<cr>',
      desc = '[Aerial]: Toggle Outline',
    },
  },
}
