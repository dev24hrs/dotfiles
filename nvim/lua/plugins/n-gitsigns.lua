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

        --  Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = '[Gitsigns]: Next Hunk ' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = '[Gitsigns]: Previous Hunk' })

        -- Actions
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[Gitsigns]: Preview Hunk' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = '[Gitsigns]: Blame Hunk' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = '[Gitsigns]: Diff This' })
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[Gitsigns]: Stage Hunk' })
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[Gitsigns]: Stage Hunk' })

        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[Gitsigns]: Reset Hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[Gitsigns]: Reset Hunk' })
        --
      end,
    })
  end,
}
