return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'lua', 'go', 'yaml' },
  config = function()
    require('conform').setup({
      format_on_save = {
        pattern = '*.lua,*.json,*.yaml,*.yml,*.md,*.go,*.sql,*.sh,*.toml',
        async = false,
        timeout_ms = 500,
      },
      format_after_save = {
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'golangci-lint', 'gofumpt' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        sql = { 'prettierd' },
        markdown = { 'prettierd' },
      },
    })
  end,
}
