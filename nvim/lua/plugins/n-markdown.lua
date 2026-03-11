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
            callout = {
                abstract = {
                    raw = '[!ABSTRACT]',
                    rendered = '󰯂 Abstract',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                summary = {
                    raw = '[!SUMMARY]',
                    rendered = '󰯂 Summary',
                    highlight = 'RenderMarkdownInfo',
                    category = 'obsidian',
                },
                tldr = { raw = '[!TLDR]', rendered = '󰦩 Tldr', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
                failure = {
                    raw = '[!FAILURE]',
                    rendered = ' Failure',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                fail = { raw = '[!FAIL]', rendered = ' Fail', highlight = 'RenderMarkdownError', category = 'obsidian' },
                missing = {
                    raw = '[!MISSING]',
                    rendered = ' Missing',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                attention = {
                    raw = '[!ATTENTION]',
                    rendered = ' Attention',
                    highlight = 'RenderMarkdownWarn',
                    category = 'obsidian',
                },
                warning = {
                    raw = '[!WARNING]',
                    rendered = ' Warning',
                    highlight = 'RenderMarkdownWarn',
                    category = 'github',
                },
                danger = {
                    raw = '[!DANGER]',
                    rendered = ' Danger',
                    highlight = 'RenderMarkdownError',
                    category = 'obsidian',
                },
                error = { raw = '[!ERROR]', rendered = ' Error', highlight = 'RenderMarkdownError', category = 'obsidian' },
                bug = { raw = '[!BUG]', rendered = ' Bug', highlight = 'RenderMarkdownError', category = 'obsidian' },
                quote = { raw = '[!QUOTE]', rendered = ' Quote', highlight = 'RenderMarkdownQuote', category = 'obsidian' },
                cite = { raw = '[!CITE]', rendered = ' Cite', highlight = 'RenderMarkdownQuote', category = 'obsidian' },
                todo = { raw = '[!TODO]', rendered = ' Todo', highlight = 'RenderMarkdownInfo', category = 'obsidian' },
                wip = { raw = '[!WIP]', rendered = '󰦖 WIP', highlight = 'RenderMarkdownHint', category = 'obsidian' },
                done = { raw = '[!DONE]', rendered = ' Done', highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
            },
            code = {
                -- border = 'thin',
                left_pad = 1,
                right_pad = 1,
                sign = false,
                style = 'language',
                language_icon = true,
                language_name = true,
                highlight_inline = 'RenderMarkdownCodeInfo',
            },
            heading = {
                icons = { ' 󰼏 ', ' 󰎨 ', ' 󰼑 ', ' 󰎲 ', ' 󰼓 ', ' 󰎴 ' },
                position = 'inline',
                border = false,
                render_modes = true, -- keep rendering while inserting
            },
            checkbox = {
                unchecked = { icon = '✘', highlight = 'RenderMarkdownUnchecked', scope_highlight = 'RenderMarkdownUnchecked' },
                checked = { icon = '✔', highlight = 'RenderMarkdownChecked', scope_highlight = 'RenderMarkdownChecked' },
                custom = {
                    question = { raw = '[?]', rendered = '', highlight = 'RenderMarkdownQuestion', scope_highlight = 'RenderMarkdownQuestion' },
                    todo = { raw = '[>]', rendered = '󰦖', highlight = 'RenderMarkdownTodo', scope_highlight = 'RenderMarkdownTodo' },
                    canceled = { raw = '[-]', rendered = '', highlight = 'RenderMarkdownCodeFallback', scope_highlight = '@text.strike' },
                    important = { raw = '[!]', rendered = '', highlight = 'DiagnosticWarn', scope_highlight = 'RenderMarkdownWarn' },
                    favorite = {
                        raw = '[~]',
                        rendered = '',
                        highlight = 'RenderMarkdownCodeFallback',
                        scope_highlight = 'RenderMarkdownCodeFallback',
                    },
                },
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
