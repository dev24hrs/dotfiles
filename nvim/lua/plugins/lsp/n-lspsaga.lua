return {
  'nvimdev/lspsaga.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    -- 'nvim-tree/nvim-web-devicons', -- optional

    dependencies = { 'echasnovski/mini.icons' },
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
    -- define keymap for lsp
    local keymap = vim.keymap
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        keymap.set('n', 'gd', function()
          local params = vim.lsp.util.make_position_params(0, 'utf-8')
          vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result, _, _)
            if not result or vim.tbl_isempty(result) then
              vim.notify('No definition found', vim.log.levels.INFO)
            else
              require('snacks').picker.lsp_definitions()
            end
          end)
        end, { buffer = event.buf, desc = 'LSP: Goto Definition' })

        local opts = { buffer = event.buf, silent = true }
        opts.desc = '[G]show [R]eferences & definition & implementation & typeDefinition'
        keymap.set('n', 'gr', '<cmd>Lspsaga finder tyd+ref+imp+def<CR>', opts)

        opts.desc = '[P]eek [D]efinition'
        keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)

        opts.desc = '[G]oto [D]efinition'
        keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)

        opts.desc = '[H]over [D]ocumentation'
        keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

        opts.desc = 'Show [O]utline'
        keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)

        opts.desc = 'Diagnostic [J]ump [N]ext'
        keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)

        opts.desc = 'Diagnostic [J]ump [P]rev'
        keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

        -- opts.desc = '[S]how [W]orkspace Diagnostics'
        -- keymap.set('n', '<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics ++float<CR>', opts)

        -- opts.desc = '[S]how Buffer [D]iagnostics'
        -- keymap.set('n', '<leader>sd', '<cmd>Lspsaga show_buf_diagnostics ++float<CR>', opts)

        opts.desc = 'Show [C]allhierarchy [I]ncoming_calls'
        keymap.set('n', 'ci', '<cmd>Lspsaga incoming_calls<CR>', opts)

        opts.desc = 'Show [C]allhierarchy [O]utgoing_calls'
        keymap.set('n', 'co', '<cmd>Lspsaga outgoing_calls<CR>', opts)

        opts.desc = '[C]ode [A]ction'
        keymap.set('n', '<leader>,', '<cmd>Lspsaga code_action<CR>', opts)

        -- folding
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method('textDocument/foldingRange') then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        -- Inlay hint
        vim.lsp.inlay_hint.enable(true)

        -- Highlight words under cursor
        if
          client
          and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
          and vim.bo.filetype ~= 'bigfile'
        then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              -- vim.cmd 'setl foldexpr <'
            end,
          })
        end
        local api, lsp = vim.api, vim.lsp
        api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
        api.nvim_create_user_command('LspLog', function()
          vim.cmd(string.format('tabnew %s', lsp.get_log_path()))
        end, {
          desc = 'Opens the Nvim LSP client log.',
        })
      end,
    })
  end,
}
