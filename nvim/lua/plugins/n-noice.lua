---@diagnostic disable: missing-fields
return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    config = function()
        require('noice').setup({
            cmdline = {
                enabled = true, -- 启用 Noice 命令行
                view = 'cmdline_popup', -- 浮窗形式
                format = {
                    cmdline = { pattern = '^:', icon = '', lang = 'vim' },
                    search_down = { pattern = '^/', icon = '', lang = 'regex' },
                    search_up = { pattern = '^%?', icon = '', lang = 'regex' },
                    lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
                },
            },
            lsp = {
                progress = { enabled = true },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = false,
                lsp_doc_border = false,
                long_message_to_split = true,
                inc_rename = false,
            },
            routes = {
                {
                    filter = {
                        event = 'msg_show',
                        kind = '',
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = 'msg_show',
                        kind = 'search_count',
                    },
                    opts = { skip = true },
                },
                {
                    view = 'split',
                    filter = { event = 'msg_show', min_height = 20 },
                },
            },
        })
        require('notify').setup({
            render = 'wrapped-compact',
            background_colour = '#000000',
        })
        vim.keymap.set('n', '<leader>sn', '<CMD>NoiceFzf<CR>', { desc = '[Notify]: Search notifications' })
    end,
}
