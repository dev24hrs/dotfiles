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

      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        --  Navigation

        local opts = '[N]ext [H]unk gitsigns'
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, opts)

        opts = '[P]revious [H]unk gitsigns'
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, opts)

        -- Actions

        opts = '[P]review [H]unk gitsigns'
        map('n', '<leader>hp', gitsigns.preview_hunk, opts)

        opts = '[B]lame [H]unk gitsigns'
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, opts)

        opts = '[B]lame [H]unk gitsigns'
        map('n', '<leader>hd', gitsigns.diffthis, opts)
        --
      end,
    })
  end,
}
