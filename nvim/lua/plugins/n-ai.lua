return {
  -- {
  --   'Exafunction/windsurf.vim',
  --   event = 'BufEnter',
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.g.codeium_no_map_tab = false
  --     vim.keymap.set('i', '<C-,>', function()
  --       return vim.fn['codeium#Accept']()
  --     end, { expr = true })
  --     vim.keymap.set('i', '<c-;>', function()
  --       return vim.fn['codeium#CycleCompletions'](1)
  --     end, { expr = true })
  --     vim.keymap.set('i', "<c-'>", function()
  --       return vim.fn['codeium#CycleCompletions'](-1)
  --     end, { expr = true })
  --     vim.keymap.set('i', '<c-x>', function()
  --       return vim.fn['codeium#Clear']()
  --     end, { expr = true })
  --   end,
  -- },

  -- copilot
  {
    'github/copilot.vim',
  },

  -- code companion
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },

    dependencies = {
      'nvim-lua/plenary.nvim',

      'j-hui/fidget.nvim',
      { 'nvim-mini/mini.diff', version = '*' },
    },
    init = function()
      require('utils.spinner'):init()
    end,
    opts = {
      display = {
        action_palette = {
          provider = 'fzf_lua',
        },
        diff = {
          enabled = true,
          -- provider = 'mini_diff',
          provider = 'inline',
        },
      },
      strategies = {
        chat = { adapter = 'copilot' },
        inline = { adapter = 'copilot' },
        -- keymaps = {
        --   accept_change = {
        --     modes = { n = 'ga' },
        --     description = 'Accept the suggested change',
        --   },
        --   reject_change = {
        --     modes = { n = 'gr' },
        --     opts = { nowait = true },
        --     description = 'Reject the suggested change',
        --   },
        -- },
      },
      language = 'English',
    },
    keys = {
      {
        '<leader>cl',
        '<CMD>CodeCompanionActions<CR>',
        mode = { 'n', 'v' },
        { noremap = true, silent = true, desc = '[C]odeCompanion Actions [L]ist' },
      },
      {
        '<leader>ca',
        '<CMD>CodeCompanion<CR>',
        mode = { 'n', 'v' },
        { noremap = true, silent = true, desc = '[C]odeCompanion [A]ction Inline' },
      },
      {
        '<leader>cc',
        '<CMD>lua require("codecompanion").chat({ window_opts = { layout = "float", width = 0.7 }})<CR>',
        mode = { 'n', 'v' },
        { noremap = true, silent = true, desc = 'Toggle [C]odeCompanion [C]hat' },
      },
      {
        '<leader>cp',
        '<CMD>CodeCompanionChat Add<CR>',
        mode = { 'v' },
        { noremap = true, silent = true, desc = '[C]odeCompanion Chat Add' },
      },
    },
  },
}
