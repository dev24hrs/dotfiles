---@diagnostic disable: missing-fields
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  config = function()
    local api = require('Comment.api')
    vim.keymap.set('n', '<leader>[', api.locked('comment.linewise.current'), { desc = 'Comment line' })
    vim.keymap.set('n', '<leader>]', api.locked('uncomment.linewise.current'), { desc = 'UnComment line' })

    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.keymap.set('x', '<leader>[', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.locked('comment.linewise')(vim.fn.visualmode())
    end, { desc = 'Comment linewise' })

    vim.keymap.set('x', '<leader>]', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.locked('uncomment.linewise')(vim.fn.visualmode())
    end, { desc = 'Uncomment linewise' })

    vim.keymap.set('x', '<leader>\\', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      api.locked('toggle.blockwise')(vim.fn.visualmode())
    end, { desc = 'Comment/Uncomment blockwise' })

    require('Comment').setup({
      padding = true,
      sticky = true,
      mappings = {
        basic = false,
        extra = false,
      },
    })
  end,
}
