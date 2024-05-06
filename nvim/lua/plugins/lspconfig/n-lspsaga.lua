return {
  'nvimdev/lspsaga.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('lspsaga').setup({
      ui = {
        border = 'single',
        devicon = true,
        title = true,
        expand = '⊞',
        collapse = '⊟',
        code_action = '',
        actionfix = '',
        lines = { '┗', '┣', '┃', '━', '┏' },
        kind = {},
        imp_sign = '󰳛 ',
      },
      lightbulb = {
        enable = true,
        sign = false, -- 设置成false 防止光标经过codeaction所在行之后的窗口抖动
        virtual_text = true,
        debounce = 10,
        sign_priority = 40,
      },
      diagnostic = {
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        max_width = 0.7,
        text_hl_follow = true,
        border_follow = false,
        extend_relatedInformation = true,
        show_layout = 'float',
        keys = {
          exec_action = 'o',
          quit = 'q',
          go_action = '<CR>',
          quit_in_show = { 'q', '<ESC>' },
        },
      },
      code_action = {
        num_shortcut = true,
        keys = { quit = 'q', exec = '<CR>' },
      },
      preview = { lines_above = 0, lines_below = 10 },
      scroll_preview = { scroll_down = '<C-f>', scroll_up = '<C-b>' },
      symbol_in_winbar = {
        enable = true,
        separator = ' › ',
        ignore_patterns = {},
        hide_keyword = false,
        show_file = true,
        folder_level = 1,
        color_mode = true,
      },
      outline = {
        win_position = 'right',
        layout = 'float', -- normal or float
        win_width = 30,
        max_height = 0.5,
        left_width = 0.3,
        detail = true,
        auto_preview = true,
        auto_close = true,
        close_after_jump = false,
        keys = {
          toggle_or_jump = 'o',
          jump = 'e',
          quit = 'q',
        },
      },
      rename = {
        in_select = true,
        auto_save = false, -- Auto save file when the rename is done
        keys = {
          quit = 'q',
          exec = '<CR>',
        },
      },
    })

    -- set keybinds
    local keymap = vim.keymap
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = '[G]show [R]eferences & definition & implementation & typeDefinition'
        keymap.set('n', 'gr', '<cmd>Lspsaga finder tyd+ref+imp+def<CR>', opts)

        opts.desc = '[P]eek [D]efinition'
        keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)

        opts.desc = '[G]oto [D]efinition'
        keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)

        opts.desc = '[H]over [D]ocumentation'
        keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

        opts.desc = '[O]utline'
        keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)

        opts.desc = 'Diagnostic [J]ump [N]ext'
        keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

        opts.desc = 'Diagnostic [J]ump [P]rev'
        keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

        opts.desc = '[S]how [W]orkspace Diagnostics'
        keymap.set('n', '<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics ++float<CR>', opts)

        opts.desc = '[S]how Buffer [D]iagnostics'
        keymap.set('n', '<leader>sd', '<cmd>Lspsaga show_buf_diagnostics ++float<CR>', opts)

        opts.desc = 'Show [C]allhierarchy [I]ncoming_calls'
        keymap.set('n', 'ci', '<cmd>Lspsaga incoming_calls<CR>', opts)

        opts.desc = 'Show [C]allhierarchy [O]utgoing_calls'
        keymap.set('n', 'co', '<cmd>Lspsaga outgoing_calls<CR>', opts)

        opts.desc = '[C]ode [A]ction'
        keymap.set('n', '<leader>,', '<cmd>Lspsaga code_action<CR>', opts)
      end,
    })
  end,
}
