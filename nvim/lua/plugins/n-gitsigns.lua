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
      current_line_blame_formatter = '      <author>, <author_time:%Y-%m-%d> - <summary>',
    })
    vim.keymap.set(
      { 'n', 'v' },
      '[h',
      '<cmd>Gitsigns next_hunk<CR>',
      { noremap = true, silent = true, desc = '[N]ext [H]unk gitsigns' }
    )
    vim.keymap.set(
      { 'n', 'v' },
      ']h',
      '<cmd>Gitsigns prev_hunk<CR>',
      { noremap = true, silent = true, desc = '[P]revious [H]unk gitsigns' }
    )
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>gd',
      '<cmd>Gitsigns diffthis<CR>',
      { noremap = true, silent = true, desc = '[G]itsigns [D]iffthis' }
    )
  end,
}
