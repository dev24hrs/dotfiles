return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fm',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]or[M]at with conform',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      json = { 'prettierd' },
      yaml = { 'yamlfmt' },
      sql = { 'prettierd' },
      markdown = { 'prettierd' },
      python = { 'isort', 'black' },
    },
    format_on_save = {
      pattern = '*.lua,*.json,*.yaml,*.yml,*.md,*.sql,*.sh,*.toml,*.md,*.go',
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
