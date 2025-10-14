return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>w',
      function()
        require('conform').format({ async = true }, function(err, did_edit)
          if not err and did_edit then
            vim.notify('Code formatted', vim.log.levels.INFO, { title = 'Conform' })
          end
        end)
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt', 'goimports' },
      json = { 'prettier' },
      yaml = { 'yamlfmt' },
      sql = { 'prettier' },
      markdown = { 'prettier' },
      python = { 'isort', 'black' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      rust = { 'rustfmt' }, -- comes with Rust installation
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
