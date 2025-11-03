return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
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
      -- mode = { 'n', 'v' },
      mode = '',
      desc = '[Conform]: Format buffer',
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { 'stylua', format_on_save = true },
      go = { 'gofumpt', 'goimports' },
      json = { 'prettier' },
      yaml = { 'yamlfmt' },
      sql = { 'prettier' },
      markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      python = { 'isort', 'black' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      rust = { 'rustfmt', lsp_format = 'fallback' }, -- comes with Rust installation
    },
    default_format_opts = {
      lsp_format = 'fallback',
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
