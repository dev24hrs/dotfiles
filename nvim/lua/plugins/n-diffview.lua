return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  config = function()
    require('diffview').setup({})

    -- 当前文件的提交记录
    -- use wl wh tab s-tab to switch panels
    vim.keymap.set('n', '<leader>df', '<cmd>DiffviewOpen<cr>', { desc = '[D]iffviewOpen [F]ile' })
    vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', { desc = '[D]iffview File [H]istory' })
    vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = '[D]iffview [C]lose' })
  end,
}
