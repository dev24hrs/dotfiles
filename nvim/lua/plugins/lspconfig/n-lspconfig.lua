-- Collection of configurations for built-in LSP client
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvimdev/lspsaga.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Diagnostic symbols
    -- local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    -- for type, icon in pairs(signs) do
    --   local hl = 'DiagnosticSign' .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    -- end
    -- vim.diagnostic.config({
    --   float = { border = 'rounded' },
    -- })

    -- import plugins
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local mason_lspconfig = require('mason-lspconfig')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    mason_lspconfig.setup_handlers({
      -- default settings for installed servers
      -- such as jsonls, sqlls, taplo, pyright, rust_analyzer
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- setting for specific servers
      ['gopls'] = function()
        lspconfig['gopls'].setup({
          capabilities = capabilities,
          settings = {
            gopls = {
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
        })
      end,

      -- ['rust_analyzer'] = function()
      --   lspconfig['rust_analyzer'].setup({
      --     capabilities = capabilities,
      --     settings = {
      --       ['rust-analyzer'] = {},
      --     },
      --   })
      -- end,

      ['lua_ls'] = function()
        lspconfig['lua_ls'].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
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
        })
      end,
    })
  end,
}
