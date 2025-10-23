-- return {
--   'lukas-reineke/indent-blankline.nvim',
--   event = 'VeryLazy',
--   main = 'ibl',
--   ---@module "ibl"
--   ---@type ibl.config
--   opts = {
--     exclude = {
--       filetypes = { 'dashboard', 'terminal', 'help', 'log', 'markdown', 'TelescopePrompt' },
--     },
--     indent = { char = '│' },
--     scope = { enabled = true },
--   },
-- }

return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup({
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
        chars = {
          '│',
        },
      },
      line_num = {
        enable = false,
      },
    })
  end,
}
