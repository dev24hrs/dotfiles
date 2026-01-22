---@type vim.lsp.Config
-- return {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = {
--     '.luarc.json',
--     '.luarc.jsonc',
--     '.luacheckrc',
--     '.stylua.toml',
--     'stylua.toml',
--     'selene.toml',
--     'selene.yml',
--     '.git',
--   },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true),
--         checkThirdParty = false,
--       },
--       hint = { enable = true },
--       codeLens = { enable = true },
--       completion = { callSnippet = 'Replace' },
--     },
--   },
-- }

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
        disable = {
          'lowercase-global',
          'undefined-global',
        },
      },
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      completion = { callSnippet = 'Replace' },
    },
  },
}
