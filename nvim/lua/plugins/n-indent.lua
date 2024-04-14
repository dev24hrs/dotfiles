-- return {
--   'lukas-reineke/indent-blankline.nvim',
--   lazy = false,
--   config = function()
--     vim.opt.list = true
--     -- vim.opt.listchars:append('eol:⤸')
--     -- vim.opt.listchars:append('space:⋅')
--     -- vim.opt.listchars:append('tab:│ ')
--     require('ibl').setup({
--       indent = { char = '│' },
--       scope = { enabled = false },
--
--       exclude = {
--         filetypes = {
--           'startify',
--           'dashboard',
--           'dotooagenda',
--           'log',
--           'fugitive',
--           'gitcommit',
--           'packer',
--           'vimwiki',
--           'markdown',
--           'json',
--           'txt',
--           'vista',
--           'help',
--           'todoist',
--           'NvimTree',
--           'peekaboo',
--           'git',
--           'TelescopePrompt',
--           'undotree',
--           'flutterToolsOutline',
--           '', -- for all buffers without a file type
--         },
--       },
--     })
--   end,
-- }
return {
  'echasnovski/mini.indentscope',
  version = '*',
  config = function()
    require('mini.indentscope').setup({
      -- draw = {
      --   animation = require('mini.indentscope').gen_animation.none(),
      -- },
    })
  end,
}
