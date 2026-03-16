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
        -- 将 StatusLine 的背景设为 NONE，继承终端背景
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', fg = '#EBDBB2' })

        local colors = {
            MAGENTA = '#A89984',
            RED = '#FB4934',
        }
        local custom_gruvbox = {
            -- 使用和终端一致的背景色,无论wezterm/ghostty有没有开启透明
            normal = {
                a = { fg = colors.RED },
                b = { fg = colors.MAGENTA },
                c = { fg = colors.MAGENTA },
                x = { fg = colors.MAGENTA },
                y = { fg = colors.MAGENTA },
                z = { fg = colors.RED },
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
