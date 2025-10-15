return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      go = { 'golangcilint' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
      sql = { 'sqlfluff' },
      -- lua = { 'luacheck' },
      rust = { 'clippy' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      markdown = { 'markdownlint' },
    }
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        local linters = lint.linters_by_ft[vim.bo.filetype]
        if linters and #linters > 0 then
          lint.try_lint()
        end
      end,
    })
  end,
}
