return {

  --  如果开代理无法安装package,需关闭代理
  --  设置npm 淘宝源 npm config set registry http://registry.npm.taobao.org/
  --  成功之后设置成官方源 npm config set registry http://registry.npmjs.org/
  'williamboman/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig', -- set lspconfig first to avoid lspconfig.util error
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    local list = {
      --- lsp ---
      'lua-language-server',
      'yaml-language-server',
      'bash-language-server',
      -- 'golangci-lint-langserver',
      'json-lsp',
      'pyright',
      'gopls',
      'rust-analyzer',
      'sqlls',
    }
    local mason_registry = require('mason-registry')
    local ensure_installed = function()
      for _, name in pairs(list) do
        if not mason_registry.is_installed(name) then
          local package = mason_registry.get_package(name)
          package:install()
        end
      end
    end
    mason_registry.refresh(vim.schedule_wrap(ensure_installed))

    require('mason-lspconfig').setup({
      automatic_installation = true,
    })
    local mason_tool_installer = require('mason-tool-installer')
    mason_tool_installer.setup({
      ensure_installed = {
        --- formatter ---
        'stylua',
        'yamlfmt',
        'gofumpt',
        'goimports',
        'golines',
        'prettierd',
        'sql-formatter',
        -- lint ---
        'golangci-lint',
        'jsonlint',
        'markdownlint', -- lint & format
        'markdownlint-cli2', -- lint & format
        'yamllint',
        'sqlfluff',
      },
    })
  end,
}
