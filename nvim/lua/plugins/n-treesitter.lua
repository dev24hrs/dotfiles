return {
    {
        'nvim-treesitter/nvim-treesitter',
        priority = 1000,
        branch = 'main',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'windwp/nvim-ts-autotag',
        },
        opts = {
            ensure_installed = {
                'bash',
                'go',
                'gomod',
                'gosum',
                'gowork',
                'lua',
                'vim',
                'vimdoc',
                'json',
                'markdown',
                'markdown_inline',
                'sql',
                'yaml',
                'regex',
                'rust',
                'toml',
                'html',
                'dockerfile',
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            -- 修复：针对 Go 禁用 Treesitter 缩进，使用 Go 自带的缩进逻辑
            indent = { enable = true, disable = { 'go' } },
            autotag = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    node_decremental = '<BS>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- 基础对象
                        ['af'] = '@function.outer', -- 选中整个函数
                        ['if'] = '@function.inner', -- 选中函数内部
                        ['ac'] = '@class.outer', -- 选中整个类/结构体
                        ['ic'] = '@class.inner', -- 选中类内部

                        -- 逻辑对象 (非常适合 Go/Rust)
                        ['ai'] = '@conditional.outer', -- 选中整个 if/else 块
                        ['ii'] = '@conditional.inner', -- 选中 if 内部逻辑
                        ['al'] = '@loop.outer', -- 选中整个 for/while 循环
                        ['il'] = '@loop.inner', -- 选中循环体内部
                        ['ap'] = '@parameter.outer', -- 选中一个函数参数 (a parameter)
                        ['ip'] = '@parameter.inner', -- 选中参数内容
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']f'] = '@function.outer', -- 下一个函数起始
                        [']c'] = '@class.outer', -- 下一个类起始
                        [']i'] = '@conditional.outer', -- 下一个 if 语句
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer', -- 上一个函数起始
                        ['[c'] = '@class.outer', -- 上一个类起始
                        ['[i'] = '@conditional.outer', -- 上一个 if 语句
                    },
                },
            },
        },
        config = function(_, opts)
            local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
            if not status_ok then
                return
            end
            configs.setup(opts)
        end,
    },
    -- Context 插件建议独立出来，方便单独控制
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufReadPost',
        opts = {
            max_lines = 3, -- 建议限制，防止占满屏幕
            mode = 'cursor', --
            line_numbers = true, --
        },
    },
}
