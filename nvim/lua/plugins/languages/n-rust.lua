return {
  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup({
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr) end,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
}
