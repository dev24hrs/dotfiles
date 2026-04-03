return {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { ".git", "Cargo.toml", "pyproject.toml" },
    settings = {
        taplo = {
            schema = {
                enabled = true,
                associations = {
                    ["Cargo.toml"] = "taplo://cargo@Cargo.toml",
                    ["pyproject.toml"] = "https://json.schemastore.org/pyproject.json",
                },
            },
        },
    },
}
