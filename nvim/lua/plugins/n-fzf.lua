return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    winopts = {
      border = 'single',
      preview = {
        border = 'single',
        layout = 'horizontal',
        scrollbar = false,
      },
    },
  },
  keys = {

    -- find files or words or buffers
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
        require('fzf-lua').lgrep_curbuf()
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
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[S]how existing [B]uffers',
    },

    -- lsp
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions()
      end,
      desc = '[G]oto [D]efinition',
    },
    {
      'gp',
      function()
        require('fzf-lua').lsp_declarations()
      end,
      desc = '[G]oto [P]eke Declarations',
    },
    {
      'gy',
      function()
        require('fzf-lua').lsp_typedefs()
      end,
      desc = '[G]oto T[Y]pe Definitions',
    },
    {
      'gi',
      function()
        require('fzf-lua').lsp_implementations()
      end,
      desc = '[G]oto [I]mplementations',
    },
    {
      'gr',
      function()
        require('fzf-lua').lsp_references()
      end,
      desc = '[G]oto [R]eferences',
    },
    {
      'gs',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = '[G]oto LSP [S]ymbols',
    },
    {
      '<leader>ci',
      function()
        require('fzf-lua').lsp_incoming_calls()
      end,
      desc = '[I]ncoming [C]alls',
    },
    {
      '<leader>co',
      function()
        require('fzf-lua').lsp_outgoing_calls()
      end,
      desc = '[O]utgoing [C]alls',
    },
    {
      '<leader>la',
      function()
        require('fzf-lua').lsp_code_actions()
      end,
      desc = '[L]SP Code [A]ctions',
    },
    {
      '<leader>lf',
      function()
        require('fzf-lua').lsp_finder()
      end,
      desc = '[L]SP [F]inder',
    },

    -- show notifications or diagnostics or keymaps
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[S]how [K]eymaps',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = '[F]ind [D]iagnostics',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = '[S]how [H]elp Pages',
    },

    -- git commands
    {
      '<leader>gf',
      function()
        require('fzf-lua').git_files()
      end,
      desc = 'List [G]it [F]iles',
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
      desc = '[G]it Commits [L]og',
    },
    {
      '<leader>gb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = '[G]it [B]ranches ',
    },
    -- fzf_colors = false,
  },
}
