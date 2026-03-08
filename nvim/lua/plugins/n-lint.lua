return {
    'mfussenegger/nvim-lint',
    -- event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        linters_by_ft = {
            go = { 'golangcilint' },
            lua = { 'selene' },
            sh = { 'shellcheck' },
            yaml = { 'yamllint' },
            json = { 'jsonlint' },
            jsonc = { 'jsonlint' },
            markdown = { 'markdownlint' },
            sql = { 'sqlfluff' },
        },
    },
    config = function(_, opts)
        local lint = require('lint')
        lint.linters_by_ft = opts.linters_by_ft

        -- 针对 SQL 动态检测方言
        lint.linters.sqlfluff.args = {
            'lint',
            '--format=json',
            '--dialect=mysql',
        }
        lint.linters.markdownlint.args = {
            '--config',
            os.getenv('HOME') .. '/config/.markdownlint.json', -- $HOME/config/.markdownlint.json
            '--',
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
        -- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        --     pattern = { '*.go' },
        --     callback = function()
        --         require('lint').try_lint('golangcilint')
        --     end,
        -- })
    end,
}
