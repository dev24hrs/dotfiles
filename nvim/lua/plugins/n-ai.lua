return {
  {
    'Exafunction/windsurf.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_virtual_text_priority = 1000
      -- diable codeium default keybindings
      -- vim.g.codeium_disable_bindings = 1
      vim.g.codeium_no_map_tab = false

      vim.keymap.set('i', '<C-,>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true })
      vim.keymap.set('i', "<c-'>", function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true })
      vim.keymap.set('i', '<c-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true })
    end,
  },

  -- code companion
  -- {
  --   'olimorris/codecompanion.nvim',
  --   cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
  --
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --
  --     'j-hui/fidget.nvim',
  --     { 'nvim-mini/mini.diff', version = '*' },
  --   },
  --   init = function()
  --     require('utils.spinner'):init()
  --   end,
  --   opts = {
  --     display = {
  --       action_palette = {
  --         provider = 'fzf_lua',
  --       },
  --       diff = {
  --         enabled = true,
  --         -- provider = 'mini_diff',
  --         provider = 'inline',
  --       },
  --     },
  --     strategies = {
  --       chat = {
  --         adapter = 'copilot',
  --       },
  --       inline = {
  --         adapter = 'openrouter',
  --       },
  --       keymaps = {
  --         accept_change = {
  --           modes = { n = 'ca' },
  --           description = '[Codecompanion]: Accept the suggested change',
  --         },
  --         reject_change = {
  --           modes = { n = 'cr' },
  --           opts = { nowait = true },
  --           description = '[Codecompanion]: Reject the suggested change',
  --         },
  --       },
  --     },
  --
  --     language = 'English',
  --   },
  --   keys = {
  --     {
  --       '<leader>cl',
  --       '<CMD>CodeCompanionActions<CR>',
  --       mode = { 'n', 'v' },
  --       { noremap = true, silent = true, desc = '[CodeCompanion]: Actions List' },
  --     },
  --     {
  --       '<leader>ca',
  --       '<CMD>CodeCompanion<CR>',
  --       mode = { 'n', 'v' },
  --       { noremap = true, silent = true, desc = '[CodeCompanion]: Action Inline' },
  --     },
  --     {
  --       '<leader>cc',
  --       '<CMD>CodeCompanionChat Toggle<CR>',
  --       mode = { 'n', 'v' },
  --       { noremap = true, silent = true, desc = '[CodeCompanion]: Toggle Chat' },
  --     },
  --     {
  --       '<leader>cp',
  --       '<CMD>CodeCompanionChat Add<CR>',
  --       mode = { 'v' },
  --       { noremap = true, silent = true, desc = '[CodeCompanion]: Chat Add' },
  --     },
  --   },
  -- },
}
