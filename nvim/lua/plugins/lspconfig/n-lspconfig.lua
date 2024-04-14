-- Collection of configurations for built-in LSP client
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'folke/neodev.nvim',
    'nvimdev/lspsaga.nvim',
    'hrsh7th/cmp-nvim-lsp',
    { 'ray-x/lsp_signature.nvim', event = 'VeryLazy' },
  },
  config = function()
    require('neodev').setup({
      lspconfig = true,
      override = function(_, library)
        library.enabled = true
        library.plugins = true
        library.types = true
      end,
    })
    require('lsp_signature').setup({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = 'rounded',
      },
    })
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
    local nvim_lsp = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local on_attach = function(_, bufnr)
      local keymap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      -- set keybinds
      -- keymap("gr", "<cmd>Telescope lsp_references<CR>", '[G]oto [R]eferences') -- show definition, references
      keymap(
        'gr',
        '<cmd>Lspsaga finder tyd+ref+imp+def<CR>',
        '[G]show [R]eferences & definition & implementation & typeDefinition '
      )

      keymap('gp', '<cmd>Lspsaga peek_definition<CR>', '[P]eek [D]efinition')
      keymap('gd', '<cmd>Lspsaga goto_definition<CR>', '[G]oto [D]efinition')
      keymap('gi', '<cmd>Telescope lsp_implementations<CR>', '[G]oto [I]mplementation')
      keymap('<leader>gd', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      keymap('K', '<cmd>Lspsaga hover_doc<CR>', '[H]over [D]ocumentation')
      -- keymap('<leader>r', '<cmd>Lspsaga rename<CR>', '[R]eName')
      keymap('<leader>o', '<cmd>Lspsaga outline<CR>', '[O]utline')
      keymap(']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Diagnostic [J]ump [N]ext')
      keymap('[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Diagnostic [J]ump] [P]rev')
      keymap(']e', function()
        require('lspsaga.diagnostic').goto_next({
          severity = vim.diagnostic.severity.ERROR,
        })
      end, 'Diagnostic jump prev')
      keymap('<leader>sw', '<cmd>Lspsaga show_workspace_diagnostics ++float<CR>', '[S]how [W]orkspace diagnostics')
      keymap('<leader>sd', '<cmd>Lspsaga show_buf_diagnostics ++float<CR>', '[S]how [B]uffer diagnostics')
      keymap('<leader>ci', '<cmd>Lspsaga incoming_calls<CR>', 'Show [C]allhierarchy [I]ncoming_calls')
      keymap('<leader>co', '<cmd>Lspsaga outgoing_calls<CR>', 'Show [C]allhierarchy [O]utgoing_calls')

      keymap('<leader>,', '<cmd>Lspsaga code_action<CR>', '[C]ode [A]ction')
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

    -- configure other lsp
    local servers = { 'bashls', 'jsonls', 'sqlls' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
    nvim_lsp.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          trace = {
            server = 'verbose',
          },
        },
      },
    })
    -- configure python lsp
    nvim_lsp.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- cause conflicts with mrcjkb/rustaceanvim
    -- configure rust lsp
    -- nvim_lsp.rust_analyzer.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   settings = {
    --     ['rust-analyzer'] = {
    --       -- checkOnSave = {
    --       --   command = 'clippy',
    --       -- },
    --     },
    --   },
    -- })
    -- configure golang lsp
    nvim_lsp.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = nvim_lsp.util.root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          gofumpt = true,
          usePlaceholders = true,
          completeUnimported = true,
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          codelenses = {
            generate = true, -- show the `go generate` lens.
            gc_details = true, -- Show a code lens toggling the display of gc's choices.
            test = true,
            tidy = true,
            vendor = true,
            regenerate_cgo = true,
            upgrade_dependency = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          staticcheck = true,
        },
      },
    })

    -- configure lua lsp
    local settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true, arrayIndex = 'Enable', setType = true },
        runtime = { version = 'LuaJIT' },
        completion = {
          callSnippet = 'Replace',
        },
        codeLens = {
          enable = true,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        disable = {
          'lowercase-global',
          'undefined-global',
          'unused-local',
          'unused-function',
          'unused-vararg',
          'trailing-space',
        },
      },
    }
    nvim_lsp.lua_ls.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
      end,
      settings = settings,
      capabilities = capabilities,
    })
    -- toml lsp
    nvim_lsp.taplo.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'toml' },
    })
  end,
}
