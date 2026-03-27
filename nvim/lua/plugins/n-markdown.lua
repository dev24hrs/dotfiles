return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            file_types = { 'markdown' },
            sign = { enabled = false },
            code = {
                sign = false,
                style = 'language',
            },
            heading = {
                -- icons = { ' 󰬺 ', ' 󰬻 ', ' 󰬼 ', ' 󰬽 ', ' 󰬾 ', ' 󰬿 ' },
                icons = { ' 󰲡 ', ' 󰲣 ', ' 󰲥 ', ' 󰲧 ', ' 󰲩 ', ' 󰲫 ' },
                position = 'inline',
                border = false,
                render_modes = true, -- keep rendering while inserting
            },
            bullet = {
                enabled = true,
                render_modes = false,
                icons = { '', '', '', '' },
            },
            checkbox = {
                enabled = true,
                render_modes = false,
                bullet = false,
                left_pad = 0,
                right_pad = 1,
                unchecked = {
                    icon = '󰄱 ',
                    highlight = 'RenderMarkdownUnchecked',
                    scope_highlight = nil,
                },
                checked = {
                    icon = '󰱒 ',
                    highlight = 'RenderMarkdownChecked',
                    scope_highlight = nil,
                },
                custom = {
                    todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
                },
                scope_priority = nil,
            },
            pipe_table = {
                -- preset = 'round',
                alignment_indicator = '─',
                border = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '│', '─' },
            },
            link = {
                wiki = { icon = ' ', highlight = 'RenderMarkdownWikiLink', scope_highlight = 'RenderMarkdownWikiLink' },
                image = ' ',
                custom = {
                    github = { pattern = 'github', icon = ' ' },
                    cern = { pattern = 'cern.ch', icon = ' ' },
                },
                hyperlink = ' ',
            },
            anti_conceal = {
                disabled_modes = { 'n' },
                ignore = {
                    bullet = true, -- render bullet in insert mode
                    head_border = true,
                    head_background = true,
                },
            },
            -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
            win_options = { concealcursor = { rendered = 'nvc' } },
            completions = {
                blink = { enabled = true },
                lsp = { enabled = true },
            },
        },
    },
    {
        '3rd/image.nvim',
        ft = { 'markdown' },
        build = false,
        opts = {
            processor = 'magick_cli',
            window_overlap_clear_enabled = true,
        },
    },
}
