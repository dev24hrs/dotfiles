---@diagnostic disable: undefined-field
return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                }
            end
        end
        -- local custom_gruvbox = require('lualine.themes.gruvbox_dark')
        local colors = {
            MAGENTA = '#a89984',
            -- DARKGRAY = '#3e3d3d',
            DARKGRAY = '#282828',
            RED = '#cb241d',
            GREEN = '#a9b665',
            YELLOW = '#d8a657',
            BLUE = '#7daea3',
            CYAN = '#89b482',
        }
        local custom_gruvbox = {
            normal = {
                a = { bg = colors.DARKGRAY, fg = colors.RED },
                b = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
                c = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
                x = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
                y = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
                z = { bg = colors.DARKGRAY, fg = colors.RED },
            },
        }

        require('lualine').setup({
            options = {
                theme = custom_gruvbox,
                section_separators = '',
                component_separators = '',
                always_divide_middle = false,
                always_show_tabline = false,
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    { 'branch', icon = '' },
                    { 'diff', symbols = { added = '+', modified = '~', removed = '-' }, source = diff_source },
                    { 'diagnostics' },
                },
                lualine_c = { 'filename' },
                lualine_x = {
                    {
                        -- 自定义组件：显示当前的缩进风格
                        function()
                            local space = vim.api.nvim_get_option_value('expandtab', { scope = 'local' })
                            local size = vim.api.nvim_get_option_value('shiftwidth', { scope = 'local' })
                            if space then
                                return 'Spaces: ' .. size
                            else
                                return 'Tab Size: ' .. size
                            end
                        end,
                    },
                    'encoding',
                    { 'fileformat', icons_enabled = true, symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' } },
                },
                lualine_y = { 'filetype' },
                lualine_z = {
                    {
                        'lsp_status',
                        icon = false,
                        symbols = {
                            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                            done = '✓',
                            separator = ' ',
                        },
                        ignore_lsp = {},
                        show_name = true,
                    },
                },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
