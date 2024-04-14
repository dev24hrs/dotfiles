return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      current_line_blame = true,
      current_line_blame_formatter_opts = { relative_time = true },
      current_line_blame_formatter = '      <author>, <author_time:%Y-%m-%d> - <summary>',
    })
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ 'n', 'v' }, '[h', '<cmd>Gitsigns next_hunk<CR>', opts)
    vim.keymap.set({ 'n', 'v' }, ']h', '<cmd>Gitsigns prev_hunk<CR>', opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>hd', '<cmd>Gitsigns diffthis<CR>', opts)
  end,
}
