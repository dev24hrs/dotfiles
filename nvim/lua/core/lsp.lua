vim.lsp.enable({
  'lua_ls',
  'gopls',
  'yamlls',
  'jsonls',
  'pyright',
  'bashls',
  'sqlls',
  'marksman',
  'rust-analyzer',
})
vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'single', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    prefix = '◍ ',
    format = function(diagnostic)
      return string.format('%s [%s] ', diagnostic.message, diagnostic.source)
    end,
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local keymap = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    keymap('<leader>r', vim.lsp.buf.rename, '[Lsp]: Rename all references')

    -- keymap for lsp useing lspsaga plugin
    keymap('<leader>,', '<CMD>Lspsaga code_action<CR>', '[Lsp]: Code Action')
    keymap('K', '<CMD>Lspsaga hover_doc<CR>', '[Lsp]: Hover Documentation')
    keymap('gd', '<CMD>Lspsaga goto_definition<CR>', '[Lsp]: Goto Definition')
    keymap('gp', '<CMD>Lspsaga peek_definition<CR>', '[Lsp]: Peek Definition')
    keymap('gi', '<CMD>Lspsaga finder imp<CR>', '[Lsp]: Goto Implementation')
    keymap('gr', '<CMD>Lspsaga finder ref<CR>', '[Lsp]: Goto References')
    keymap('gs', '<CMD>Lspsaga outline<CR>', '[Lsp]: Goto Outline Symbols')
    keymap('[d', '<CMD>Lspsaga diagnostic_jump_prev<CR>', '[Lsp]: Diagnostic Previous')
    keymap(']d', '<CMD>Lspsaga diagnostic_jump_next<CR>', '[Lsp]: Diagnostic Next')
    keymap('<leader>ld', '<CMD>Lspsaga show_buf_diagnostics ++float<CR>', '[Lsp]: Show Buffer Diagnostics')
    keymap('<leader>lw', '<CMD>Lspsaga show_workspace_diagnostics ++float<CR>', '[Lsp]: Show Workspace Diagnostics')
    keymap('<leader>li', '<CMD>Lspsaga incoming_calls<CR>', '[Lsp]: Incoming Calls')
    keymap('<leader>lo', '<CMD>Lspsaga outgoing_calls<CR>', '[Lsp]: Outgoing Calls')
    keymap('<leader>lf', '<CMD>Lspsaga finder tyd+ref+imp+def<CR>', '[Lsp]: Lsp Finder')

    -- Highlight words under cursor
    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
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
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end
    -- folding
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- lsp
    local api, lsp = vim.api, vim.lsp
    api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
    api.nvim_create_user_command('LspLog', function()
      vim.cmd(string.format('tabnew %s', lsp.get_log_path()))
    end, {
      desc = 'Opens the Nvim LSP client log.',
    })
    -- Inlay hint
    vim.lsp.inlay_hint.enable(true)
  end,
})
