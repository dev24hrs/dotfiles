return {
    {
        'kevinhwang91/nvim-hlslens',
        event = 'VeryLazy',
        config = function()
            require('hlslens').setup()
            vim.api.nvim_set_keymap(
                'n',
                'n',
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = '[Hlslens]: Prev Search Word' }
            )
            vim.api.nvim_set_keymap(
                'n',
                'N',
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = '[Hlslens]: Next Search Word' }
            )

            -- use n or N or * or # to jump to next or prev
            local desc = { noremap = true, silent = true, desc = '[Hlslens]: Search Word' }
            vim.api.nvim_set_keymap('n', '*', [[<Cmd>lua require('hlslens').start()<CR>]], desc)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], desc)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], desc)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], desc)
        end,
    },
    {
        'nvim-pack/nvim-spectre',
        event = 'VeryLazy',
        config = function()
            require('spectre').setup({
                color_devicons = true,
                live_update = true,
                lnum_for_results = true,
                line_sep_start = '┌-----------------------------------------',
                result_padding = '¦  ',
                line_sep = '└-----------------------------------------',
                mapping = {
                    ['tab'] = {
                        map = '<Tab>',
                        cmd = "<cmd>lua require('spectre').tab()<cr>",
                        desc = 'next query',
                    },
                    ['shift-tab'] = {
                        map = '<S-Tab>',
                        cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
                        desc = 'previous query',
                    },
                    ['enter_file'] = {
                        map = 'o',
                        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                        desc = 'open file',
                    },
                    ['run_current_replace'] = {
                        map = '<cr>',
                        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                        desc = '[Spectre]: replace current line',
                    },
                    ['run_replace'] = {
                        map = '<cr>',
                        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                        desc = '[Spectre]: replace all',
                    },
                },
                is_block_ui_break = true,
            })
            vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
                desc = '[Spectre]: Search word on project',
            })
            vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
                desc = '[Spectre]: Search current word on project',
            })
            vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
                desc = '[Spectre]: Search on current file',
            })
        end,
    },
}
