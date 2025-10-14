return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
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
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        disable = {
          'lowercase-global',
          'undefined-global',
          'missing-parameter',
          'param-type-mismatch',
        },
        globals = {
          'vim',
          'Snacks',
        },
      },
      hint = { enable = true },
      codeLens = { enable = true },
      completion = { callSnippet = 'Replace' },
    },
  },
}
