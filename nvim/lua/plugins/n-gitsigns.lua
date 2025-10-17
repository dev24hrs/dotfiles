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
        end, { desc = '[N]ext [H]unk gitsigns' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = '[P]revious [H]unk gitsigns' })

        -- Actions

        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review [H]unk gitsigns' })

        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = '[B]lame [H]unk gitsigns' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff [T]his gitsigns' })

        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage [H]unk gitsigns' })

        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[S]tage [H]unk gitsigns' })

        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset [H]unk gitsigns' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[R]eset [H]unk gitsigns' })
        --
      end,
    })
  end,
}
