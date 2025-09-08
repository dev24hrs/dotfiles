return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    winopts = {
      height = 0.75,
      width = 0.7,
    },
  },
  keys = {
    -- find files or words
    {
      '<leader>fl',
      function()
        require('fzf-lua').files()
      end,
      desc = '[F]iles [L]ist in project directory',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_curbuf()
      end,
      desc = '[F]ind [W]ord in current buffer',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = '[F]ind [G]rep words in project directory',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = '[Find] [R]ecent files',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = '[F]ind in neovim [C]onfiguration',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = '[F]ind [D]iagnostics',
    },

    -- show buffers and keymaps
    {
      '<leader>sb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[S]how existing [B]uffers',
    },
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[S]how [K]eymaps',
    },

    -- git commands
    {
      '<leader>gl',
      function()
        require('fzf-lua').git_files()
      end,
      desc = '[G]it [L]ist files',
    },
    {
      '<leader>gs',
      function()
        require('fzf-lua').git_status()
      end,
      desc = '[G]it [S]tatus',
    },
    {
      '<leader>gd',
      function()
        require('fzf-lua').git_diff()
      end,
      desc = '[G]it [D]iff',
    },
    {
      '<leader>gl',
      function()
        require('fzf-lua').git_commits()
      end,
      desc = '[G]it [C]ommits log',
    },
    {
      '<leader>gb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = '[G]it [B]ranches ',
    },
    fzf_colors = false,
  },
}
