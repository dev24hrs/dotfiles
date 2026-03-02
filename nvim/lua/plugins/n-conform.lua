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
            yaml = { 'yamlfmt' },
            sql = { 'sqlfmt' },
            json = { 'prettierd' },
            markdown = { 'prettierd', 'markdown-toc', stop_after_first = true },
            ['markdown.mdx'] = { 'prettierd', 'markdown-toc', stop_after_first = true },
            python = { 'isort', 'black' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            toml = { 'taplo' },
            rust = { 'rustfmt', lsp_format = 'fallback' }, -- comes with Rust installation
        },
        formatters = {
            taplo = { command = 'taplo', args = { 'fmt', '--option', 'indent_tables=false', '-' } },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
        format_on_save = {
            pattern = '*.lua,*.json,*.jsonc,*.yaml,*.yml,*.md,*.sql,*.sh,*.toml,*.md,*.go',
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
