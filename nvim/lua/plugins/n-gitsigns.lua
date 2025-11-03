return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup({
      numhl = true,
      current_line_blame = true,
      current_line_blame_formatter = '      <author>, <author_time:%Y-%m-%d> - <summary>',
      preview_config = {
        border = 'single',
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[Gitsigns]: Preview Hunk' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = '[Gitsigns]: Blame Hunk' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = '[Gitsigns]: Diff This' })
      end,
    })
  end,
}
