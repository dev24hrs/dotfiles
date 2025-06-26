---@diagnostic disable: undefined-doc-name, undefined-global
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true, replace_netrw = true },
    indent = { enabled = true },
    quickfile = { enabled = true },

    notifier = {
      enabled = true,
    },
    picker = {
      enabled = true,
    },
  },
  keys = {

    -- Explorer
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },
    {
      '<leader>sn',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent Files',
    },

    -- git
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },

    -- others
    {
      '<leader>cr',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
  },
}
