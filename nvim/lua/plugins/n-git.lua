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
            signs_staged = {
                add = { text = '│' },
                change = { text = '│' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            signcolumn = true,
            current_line_blame = true,
            current_line_blame_formatter = '		 <author_mail>, <author_time:%Y-%m-%d> • <summary> • <abbrev_sha>',
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                -- Navigation
                map('n', ']h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = '[Gitsigns]: Next Hunk' })

                map('n', '[h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = '[Gitsigns]: Previous Hunk' })

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = '[Gitsigns]: Show Blame Line' })
            end,
        })
    end,
}
-- return {
--     'f-person/git-blame.nvim',
--     event = 'VeryLazy',
--     config = function()
--         require('gitblame').setup({
--             enabled = true,
--             message_template = '      <author>, <date> • <summary> • <<sha>>',
--             date_format = '%Y-%m-%d %H:%M',
--             virtual_text_column = 1,
--         })
--         vim.g.gitblame_highlight_group = 'Comment'
--         vim.g.gitblame_use_blame_commit_file_urls = true
--         vim.g.gitblame_max_commit_summary_length = 60
--     end,
-- }
