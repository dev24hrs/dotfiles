---@diagnostic disable: undefined-doc-name
local root_markers1 = {
    '.emmyrc.json',
    '.luarc.json',
    '.luarc.jsonc',
}
local root_markers2 = {
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
}

---@type vim.lsp.Config
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2, { '.git' } }
        or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { '.git' }),
    settings = {
        Lua = {
            workspace = { library = { vim.api.nvim_get_runtime_file('', true) } },
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
