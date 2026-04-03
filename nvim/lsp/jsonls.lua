return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { ".git" },
    settings = {
        json = {
            validate = { enable = true },
            schemas = {
                {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                },
                {
                    fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                    fileMatch = { ".eslintrc.json", ".eslintrc" },
                    url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                    fileMatch = { ".prettierrc.json", ".prettierrc" },
                    url = "https://json.schemastore.org/prettierrc.json",
                },
            },
        },
    },
}
