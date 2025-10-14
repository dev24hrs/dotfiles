return {
  cmd = { 'gopls' }, -- Command to start the language server
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl', 'gosum' }, -- File types that this server will handle
  root_markers = { 'go.mod', 'go.work', '.git' }, -- Markers to identify the root of the project
  settings = { -- Settings for the language server
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      buildFlags = { '-tags=integration' },
      semanticTokens = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = true,
        functionTypeParameters = false,
        parameterNames = true,
        rangeVariableTypes = false,
      },
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        unreachable = true,
        unmarshal = true,
        unsafeptr = true,
        unusedfunc = true,
        unusedresult = true,
        unusedvariable = true,
        stylecheck = true,
        buildtag = true,
        contextcheck = true,
        shadow = true,
        structtag = true,
        tests = true,
        timeformat = true,
      },
    },
  },
}
