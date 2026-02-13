return {
  'stevearc/aerial.nvim',
  event = 'LspAttach',
  opts = {
    attach_mode = 'global',
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    disable_max_lines = 5000,
    -- filter_kind = false,
    filter_kind = {
      'Class',
      'Constructor',
      'Enum',
      'Function',
      'Interface',
      'Module',
      'Method',
      'Struct',
    },
    highlight_on_hover = true,
    ignore = { filetypes = { 'gomod' } },
    layout = { min_width = 20, width = 30, default_direction = 'prefer_right', resize_to_content = true },
    show_guides = true,
    autojump = true,
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
