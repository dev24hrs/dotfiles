-- return {
--   'stevearc/conform.nvim',
--   lazy = true,
--   event = { 'BufReadPre', 'BufNewFile' },
--   ft = { 'lua', 'go', 'yaml' },
--   config = function()
--     require('conform').setup({
--       format_on_save = {
--         pattern = '*.lua,*.json,*.yaml,*.yml,*.md,*.go,*.sql,*.sh,*.toml',
--         lsp_fallback = true,
--         timeout_ms = 500,
--       },
--       format_after_save = {
--         lsp_fallback = true,
--       },
--       formatters_by_ft = {
--         lua = { 'stylua' },
--         go = { 'gofumpt', 'goimports' },
--         json = { 'prettierd' },
--         yaml = { 'prettierd' },
--         sql = { 'prettierd' },
--         markdown = { 'prettierd' },
--       },
--     })
--   end,
-- }

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>m',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      json = { 'prettierd' },
      yaml = { 'prettierd' },
      sql = { 'prettierd' },
      markdown = { 'prettierd' },
      python = { 'isort', 'black' },
    },
    format_on_save = {
      pattern = '*.lua,*.json,*.yaml,*.yml,*.md,*.go,*.sql,*.sh,*.toml',
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
