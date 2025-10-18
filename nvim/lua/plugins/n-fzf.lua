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
      desc = '[Fzf]: Files List in project',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').lgrep_curbuf()
      end,
      desc = '[Fzf]: Find Word in current buffer',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = '[Fzf]: Find Grep words in project',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = '[Fzf]: Find Recent files',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = '[Fzf]: Find in neovim Configuration',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[Fzf]: Find existing Buffers',
    },

    -- lsp
    {
      'gd',
      function()
        require('fzf-lua').lsp_definitions()
      end,
      desc = '[Fzf]: Goto Definition',
    },
    {
      'gp',
      function()
        require('fzf-lua').lsp_declarations()
      end,
      desc = '[Fzf]: Goto Peke Declarations',
    },
    {
      'gy',
      function()
        require('fzf-lua').lsp_typedefs()
      end,
      desc = '[Fzf]: Goto TYpe Definitions',
    },
    {
      'gi',
      function()
        require('fzf-lua').lsp_implementations()
      end,
      desc = '[Fzf]: Goto Implementations',
    },
    {
      'gr',
      function()
        require('fzf-lua').lsp_references()
      end,
      desc = '[Fzf]: Goto References',
    },
    {
      'gs',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = '[Fzf]: Goto LSP Symbols',
    },
    {
      '<leader>ci',
      function()
        require('fzf-lua').lsp_incoming_calls()
      end,
      desc = '[Fzf]: Incoming Calls',
    },
    {
      '<leader>co',
      function()
        require('fzf-lua').lsp_outgoing_calls()
      end,
      desc = '[Fzf]: Outcoming Calls',
    },
    {
      '<leader>la',
      function()
        require('fzf-lua').lsp_code_actions()
      end,
      desc = '[Fzf]: LSP Code Actions',
    },
    {
      '<leader>lf',
      function()
        require('fzf-lua').lsp_finder()
      end,
      desc = '[Fzf]: LSP Finder',
    },

    -- show notifications or diagnostics or keymaps
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[Fzf]: Show Keymaps',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = '[Fzf]: Show Diagnostics',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = '[Fzf]: Show Neovim Help Pages',
    },

    -- git commands
    {
      '<leader>gf',
      function()
        require('fzf-lua').git_files()
      end,
      desc = '[Fzf]: List Git Files',
    },
    {
      '<leader>gs',
      function()
        require('fzf-lua').git_status()
      end,
      desc = '[Fzf]: List Git Status',
    },
    {
      '<leader>gd',
      function()
        require('fzf-lua').git_diff()
      end,
      desc = '[Fzf]: List Git Diff',
    },
    {
      '<leader>gl',
      function()
        require('fzf-lua').git_commits()
      end,
      desc = '[Fzf]: List Git Commits Log',
    },
    {
      '<leader>gb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = '[Fzf]: List Git Branches',
    },
    -- fzf_colors = false,
  },
}
