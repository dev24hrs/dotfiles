vim.lsp.enable({
  'lua_ls',
  'gopls',
  'yamlls',
  'jsonls',
  'pyright',
  'bashls',
  'sqlls',
  'rust-analyzer',
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'single' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    prefix = '◍ ',
    format = function(diagnostic)
      return string.format('%s [%s] ', diagnostic.message, diagnostic.source)
    end,
    spacing = 5,
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

    keymap('<leader>,', vim.lsp.buf.code_action, 'Code Action')
    keymap('<leader>r', vim.lsp.buf.rename, 'Rename all references')
    keymap('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- 自动高亮光标下内容的引用，并在光标移动时清除
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
    if client and client.supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- Inlay hint
    vim.lsp.inlay_hint.enable(true)
  end,
})
