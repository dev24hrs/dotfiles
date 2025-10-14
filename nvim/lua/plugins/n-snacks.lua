---@diagnostic disable: undefined-doc-name
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = true },
    -- indent = { enabled = true, char = '╎', scope = { char = '╎' } },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'cancel', mode = 'i' },
          },
        },
      },
      sources = {
        explorer = {
          auto_close = true,
        },
        files = { hidden = true },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    -- File Explorer
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = '[F]ile [E]xplorer',
    },

    -- search files or words or buffers
    {
      '<leader>fl',
      function()
        Snacks.picker.files()
      end,
      desc = '[F]iles [L]ist in project directory',
    },
    {
      '<leader>fw',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = '[F]ind [W]ord in current buffer',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.grep()
      end,
      desc = '[F]ind [G]rep words in project directory',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = '[Find] [R]ecent files',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = '[F]ind [C]onfig File',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = {
                ['dd'] = 'bufdelete',
                ['<c-d>'] = { 'bufdelete', mode = { 'n', 'i' } },
              },
            },
            list = { keys = { ['dd'] = 'bufdelete' } },
          },
        })
      end,
      desc = '[F]ind [B]uffers',
    },

    -- projects
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = '[F]ind [P]Projects',
    },

    -- show notifications or diagnostics
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = '[S]how Buffer [D]iagnostics',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[S]how [W]orkspace [D]iagnostics',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[S]how [N]otification',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = '[S]how [K]eymaps',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = '[S]how [M]arks',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = '[S]how [Q]uickfix List',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]how [H]elp Pages',
    },

    -- lsp
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = '[G]oto [D]efinition',
    },
    {
      'gp',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = '[G]oto [P]eke Declaration',
    },
    {
      'gi',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = '[G]oto [I]mplementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = '[G]oto T[y]pe Definition',
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = '[G]oto [R]eferences',
    },
    {
      'gs',
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = '[G]oto LSP [S]ymbols',
    },
    -- git
    {
      '<leader>gf',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find [G]it [F]iles',
    },
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = '[G]it [B]ranches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = '[G]it [L]og',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = '[G]it [S]tatus',
    },
    {
      '<leader>gh',
      function()
        Snacks.picker.git_stash()
      end,
      desc = '[G]it Stas[h]',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = '[G]it [D]iff (Hunks)',
    },
  },
}
