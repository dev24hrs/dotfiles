return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config = function()
    require('gitsigns').setup({
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
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = '[Gitsigns]: Show Blame Line' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = '[Gitsigns]: Diff This' })
      end,
    })
  end,
}
