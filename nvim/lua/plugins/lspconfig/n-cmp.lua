---@diagnostic disable: missing-fields
return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind.nvim',
  },
  config = function()
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local luasnip = require('luasnip')
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    require('luasnip.loaders.from_vscode').lazy_load()
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          menu = {
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[Latex]',
          },
        }),
      },
      enabled = function()
        if
          require('cmp.config.context').in_treesitter_capture('comment') == true
          or require('cmp.config.context').in_syntax_group('Comment')
        then
          return false
        else
          return true
        end
      end,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = false,
        git = {
          async = true,
        },
      },
      preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'nvim_lsp_signature_help' },
      }, { { name = 'buffer' } }),

      -- 根据文件类型补全
      cmp.setup.filetype({ 'TelescopePrompt' }, {
        sources = cmp.config.sources({
          { name = 'buffer' },
        }),
      }),
      cmp.setup.filetype({ 'vim', 'markdown' }, {
        sources = cmp.config.sources({
          { name = 'buffer' },
        }),
      }),
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'buffer' },
        }),
      }),
    })
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
      view = {
        entries = { name = 'wildmenu', separator = '|' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
      }),
    })
  end,
}
