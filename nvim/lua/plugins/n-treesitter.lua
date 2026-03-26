return {
    {
        'nvim-treesitter/nvim-treesitter',
        priority = 1000,
        branch = 'main',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
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
                        -- 这里的 "f" 代表 function, "p" 代表 parameter
                        ['af'] = { query = '@function.outer', desc = '选中整个函数' },
                        ['if'] = { query = '@function.inner', desc = '选中函数体内部' },
                        ['ac'] = { query = '@class.outer', desc = '选中整个结构体/类' },
                        ['ic'] = { query = '@class.inner', desc = '选中结构体内部内容' },
                        ['ap'] = { query = '@parameter.outer', desc = '选中整个参数' },
                        ['ip'] = { query = '@parameter.inner', desc = '选中参数内容' },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- 将跳转记录在 jumplist 中 (可以用 Ctrl+o 跳回)
                    goto_next_start = {
                        [']f'] = { query = '@function.outer', desc = '跳到下一个函数开始' },
                        [']m'] = { query = '@class.outer', desc = '跳到下一个结构体开始' },
                    },
                    goto_previous_start = {
                        ['[f'] = { query = '@function.outer', desc = '跳到上一个函数开始' },
                        ['[m'] = { query = '@class.outer', desc = '跳到上一个结构体开始' },
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
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    -- Context 插件建议独立出来，方便单独控制
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufReadPost',
        opts = {
            max_lines = 3, -- 建议限制，防止占满屏幕
            mode = 'cursor',
            line_numbers = true,
        },
    },
}
