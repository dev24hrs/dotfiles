return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>w',
            function()
                require('conform').format({
                    async = true,
                    lsp_fallback = true,
                }, function(err)
                    if not err then
                        -- 核心改进：格式化成功后立即保存文件
                        vim.api.nvim_command('write')
                        vim.notify('Formatted & Saved', vim.log.levels.INFO, { title = 'Conform' })
                    end
                end)
            end,
            mode = 'n',
            desc = '[Conform]: Format buffer',
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            go = { 'gofumpt', 'goimports' },
            sql = { 'sql-formatter' },
            yaml = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'prettierd' },
            jsonc = { 'prettierd' },
            markdown = { 'prettierd', 'markdown-toc', stop_after_first = true },
            ['markdown.mdx'] = { 'prettierd', 'markdown-toc', stop_after_first = true },
            python = { 'isort', 'black' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            toml = { 'taplo' },
            rust = { 'rustfmt' }, -- comes with Rust installation
            fish = { 'fish_indent' }, -- comes with Fish installation
            -- 在没有特定格式化器时尝试用 LSP 格式化
            ['_'] = { "lsp_format = 'fallback'" },
        },
        formatters = {
            taplo = { command = 'taplo', args = { 'fmt', '--option', 'indent_tables=false', '-' } },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        -- 添加：保存时自动删除行尾空格
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = { '*' },
            callback = function()
                local save_cursor = vim.fn.getpos('.')
                vim.cmd([[%s/\s\+$//e]])
                vim.fn.setpos('.', save_cursor)
            end,
        })
    end,
}
