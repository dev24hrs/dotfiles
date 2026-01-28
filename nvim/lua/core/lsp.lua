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
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'single', style = 'minimal' },
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

    keymap('grr', '', '[Basic]: cancel grr default') -- vim.lsp.buf.references()
    keymap('grt', '', '[Basic]: cancel grt default') -- vim.lsp.buf.type_definition()
    keymap('gra', '', '[Basic]: cancel gra default') -- vim.lsp.buf.code_action()
    keymap('gri', '', '[Basic]: cancel gri default') -- vim.lsp.buf.implementation()
    keymap('grn', '', '[Basic]: cancel grn default') -- vim.lsp.buf.rename()

    -- keymap for lsp useing lspsaga plugin
    keymap('<leader>,', '<CMD>Lspsaga code_action<CR>', '[Lsp]: Code Action')
    keymap('K', '<CMD>Lspsaga hover_doc<CR>', '[Lsp]: Hover Documentation')
    keymap('gd', '<CMD>Lspsaga goto_definition<CR>', '[Lsp]: Goto Definition')
    keymap('gp', '<CMD>Lspsaga peek_definition<CR>', '[Lsp]: Peek Definition')
    keymap('gi', '<CMD>Lspsaga finder imp<CR>', '[Lsp]: Goto Implementation')
    keymap('gr', '<CMD>Lspsaga finder ref<CR>', '[Lsp]: Goto References')
    -- keymap('gs', '<CMD>Lspsaga outline<CR>', '[Lsp]: Goto Outline Symbols')
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
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
    -- api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })
    api.nvim_create_user_command('LspLog', function()
      vim.cmd(string.format('tabnew %s', lsp.get_log_path()))
    end, {
      desc = 'Opens the Nvim LSP client log.',
    })
    -- Inlay hint
    vim.lsp.inlay_hint.enable(true)
  end,
})

-- LspInfo: Comprehensive LSP information
vim.api.nvim_create_user_command('LspInfo', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  print('═══════════════════════════════════')
  print('           LSP INFORMATION          ')
  print('═══════════════════════════════════')
  print('')

  print('󰈙 Language client log: ' .. vim.lsp.get_log_path())
  print('󰈔 Detected filetype: ' .. vim.bo.filetype)
  print('󰈮 Buffer: ' .. bufnr)
  print('󰈔 Root directory: ' .. (vim.fn.getcwd() or 'N/A'))
  print('')

  if #clients == 0 then
    print('󰅚 No LSP clients attached to buffer ' .. bufnr)
    print('')
    print('Possible reasons:')
    print('  • No language server installed for ' .. vim.bo.filetype)
    print('  • Language server not configured')
    print('  • Not in a project root directory')
    print('  • File type not recognized')
    return
  end

  print('󰒋 LSP clients attached to buffer ' .. bufnr .. ':')
  print('─────────────────────────────────')

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s', i, client.name))
    print('  ID: ' .. client.id)
    print('  Root dir: ' .. (client.config.root_dir or 'Not set'))
    -- print('  Command: ' .. table.concat(client.config.cmd or {}, ' '))
    print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    if client.is_stopped() then
      print('  Status: 󰅚 Stopped')
    else
      print('  Status: 󰄬 Running')
    end

    if client.workspace_folders and #client.workspace_folders > 0 then
      print('  Workspace folders:')
      for _, folder in ipairs(client.workspace_folders) do
        print('    • ' .. folder.name)
      end
    end

    local attached_buffers = {}
    for buf, _ in pairs(client.attached_buffers or {}) do
      table.insert(attached_buffers, buf)
    end
    print('  Attached buffers: ' .. #attached_buffers)

    local caps = client.server_capabilities
    local key_features = {}
    if caps.completionProvider then
      table.insert(key_features, 'completion')
    end
    if caps.hoverProvider then
      table.insert(key_features, 'hover')
    end
    if caps.definitionProvider then
      table.insert(key_features, 'definition')
    end
    if caps.documentFormattingProvider then
      table.insert(key_features, 'formatting')
    end
    if caps.codeActionProvider then
      table.insert(key_features, 'code_action')
    end

    if #key_features > 0 then
      print('  Key features: ' .. table.concat(key_features, ', '))
    end

    print('')
  end

  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics > 0 then
    print('󰒡 Diagnostics Summary:')
    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      counts[severity] = counts[severity] + 1
    end

    print('  󰅚 Errors: ' .. counts.ERROR)
    print('  󰀪 Warnings: ' .. counts.WARN)
    print('  󰋽 Info: ' .. counts.INFO)
    print('  󰌶 Hints: ' .. counts.HINT)
    print('  Total: ' .. #diagnostics)
  else
    print('󰄬 No diagnostics')
  end

  print('')
  print('Use :LspLog to view detailed logs')
  print('Use :LspCapabilities for full capability list')
end, { desc = 'Show comprehensive LSP information' })

-- LspRestart: Restart LSP clients for current buffer
vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify('No LSP clients attached to restart', vim.log.levels.WARN)
    return
  end

  for _, client in ipairs(clients) do
    vim.notify('Restarting ' .. client.name, vim.log.levels.INFO)
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd('edit')
  end, 100)
end, { desc = 'Restart LSP clients for current buffer' })

-- LspStatus: Show brief LSP status
vim.api.nvim_create_user_command('LspStatus', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    print('󰅚 No LSP clients attached')
    return
  end

  print('󰒋 LSP Status for buffer ' .. bufnr .. ':')
  print('─────────────────────────────────')

  for i, client in ipairs(clients) do
    print(string.format('󰌘 Client %d: %s (ID: %d)', i, client.name, client.id))
    print('  Root: ' .. (client.config.root_dir or 'N/A'))
    print('  Filetypes: ' .. table.concat(client.config.filetypes or {}, ', '))

    local caps = client.server_capabilities
    local features = {}
    if caps.completionProvider then
      table.insert(features, 'completion')
    end
    if caps.hoverProvider then
      table.insert(features, 'hover')
    end
    if caps.definitionProvider then
      table.insert(features, 'definition')
    end
    if caps.referencesProvider then
      table.insert(features, 'references')
    end
    if caps.renameProvider then
      table.insert(features, 'rename')
    end
    if caps.codeActionProvider then
      table.insert(features, 'code_action')
    end
    if caps.documentFormattingProvider then
      table.insert(features, 'formatting')
    end

    print('  Features: ' .. table.concat(features, ', '))
    print('')
  end
end, { desc = 'Show brief LSP status' })
