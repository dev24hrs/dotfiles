return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      json = { 'prettier' },
      yaml = { 'yamlfmt' },
      sql = { 'prettier' },
      markdown = { 'prettier' },
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
