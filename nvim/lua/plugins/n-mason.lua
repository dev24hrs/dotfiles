return {

  --  如果开代理无法安装package,需关闭代理
  --  设置npm 淘宝源 npm config set registry http://registry.npm.taobao.org/
  --  成功之后设置成官方源 npm config set registry http://registry.npmjs.org/
  'mason-org/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig', -- set lspconfig first to avoid lspconfig.util error
    'mason-org/mason-lspconfig.nvim',
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

    require('mason-lspconfig').setup({
      automatic_installation = true,
      ensure_installed = {
        --- lsp ---
        'lua_ls',
        'yamlls',
        'bashls',
        'jsonls',
        'pyright',
        'gopls',
        'rust_analyzer',
        'sqlls',
      },
    })
    require('mason-tool-installer').setup({
      ensure_installed = {
        --- formatter ---
        'stylua',
        'yamlfmt',
        'gofumpt',
        'goimports',
        'prettier',
        'sql-formatter',
        -- lint ---
        'golangci-lint',
        'jsonlint',
        'yamllint',
        'sqlfluff',
      },
    })
  end,
}
