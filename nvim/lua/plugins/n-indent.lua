return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    exclude = {
      filetypes = { 'dashboard', 'terminal', 'help', 'log', 'markdown', 'TelescopePrompt' },
    },
    indent = { char = '│' },
    scope = { enabled = false },
  },
}
