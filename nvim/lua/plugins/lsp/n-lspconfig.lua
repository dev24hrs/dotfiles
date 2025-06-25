-- Collection of configurations for built-in LSP client

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvimdev/lspsaga.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },

  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'yamlls',
        'bashls',
        'jsonls',
        'pyright',
        'gopls',
        'sqlls',
        'rust_analyzer',
      },
      automatic_enable = true,
    })

    -- lsp config
    vim.lsp.config('rust_analyzer', {
      -- Server-specific settings. See `:help lsp-quickstart`
      settings = {
        ['rust-analyzer'] = {},
      },
    })
    vim.lsp.config['gopls'] = {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_markers = { 'go.mod', 'go.work', '.git' },
      settings = {
        ['gopls'] = {
          ['formatting.gofumpt'] = true,
          -- ['ui.semanticTokens'] = true,
          ['ui.completion.usePlaceholders'] = true,
          ['ui.diagnostic.staticcheck'] = true,
          ['ui.diagnostic.analyses'] = {
            unusedparams = true,
            unusedwrite = true,
            unusedvariable = true,
            shadow = true,
          },
          ['ui.inlayhint.hints'] = {
            parameterNames = true,
            constantValues = true,
          },
        },
      },
    }
    vim.lsp.config['lua_ls'] = {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_marks = { { '.luarc.json', 'luarc.json' }, '.git' },
      settings = {
        ['Lua'] = {
          runtime = {
            version = 'LuaJIT',
          },
          hint = { enable = true },
          codeLens = { enable = true },
          diagnostics = {
            globals = { 'vim' },
          },
          completion = { callSnippet = 'Replace' },
          disable = {
            'lowercase-global',
            'undefined-global',
            'unused-local',
            'unused-function',
            'unused-vararg',
            'trailing-space',
          },
        },
      },
    }
  end,
}
