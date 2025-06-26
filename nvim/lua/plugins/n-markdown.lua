return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('render-markdown').setup({
        enabled = true,
        file_types = { 'markdown' },
        heading = { position = 'inline' },
        code = { sign = false, style = 'normal' },
        pipe_table = { preset = 'round' },
        bullet = { icons = { '-', '-' } },
        latex = { enabled = false },
      })
    end,
  },
}
