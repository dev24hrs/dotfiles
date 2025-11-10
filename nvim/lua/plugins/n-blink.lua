return {
  {
    'saghen/blink.cmp',
    event = { 'BufReadPost', 'BufNewFile', 'InsertEnter' },
    version = '1.*',
    dependencies = {
      -- 'rafamadriz/friendly-snippets',
      'Exafunction/windsurf.nvim',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        -- dependencies = 'rafamadriz/friendly-snippets',
        init = function()
          -- load my snippets
          require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
        end,
      },
    },
    opts = {
      snippets = { preset = 'luasnip' },
      appearance = { nerd_font_variant = 'normal' },
      keymap = {
        preset = 'none',
        -- use tab s-tab or up down to select items
        -- enter to accept selected item
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<CR>'] = { 'accept', 'fallback' }, -- 更改成'select_and_accept'会选择第一项插入

        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-j>'] = { 'select_prev', 'fallback' },
        ['<C-k>'] = { 'select_next', 'fallback' },
        ['<Esc>'] = { 'cancel', 'fallback' },
      },
      completion = {
        keyword = { range = 'full' },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = { enabled = true },
        menu = {
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
          scrolloff = 1,
          scrollbar = false,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon' },
              { 'kind' },
              { 'source_name' },
            },
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          window = {
            scrollbar = false,
            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          },
          auto_show = true,
          treesitter_highlighting = true,
        },
      },
      signature = { enabled = true },
      sources = {
        default = { 'codeium', 'lsp', 'snippets', 'buffer', 'path', 'lazydev' },
        providers = {
          codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 90,
          },
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
                return 3
              end
              return 0
            end,
          },
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
        },
      },
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ':'
            end,
          },
          ghost_text = { enabled = false },
        },
        keymap = {
          ['<CR>'] = { 'select_and_accept', 'fallback' },
          ['<Space>'] = { 'select_and_accept', 'fallback' },
        },
      },
      fuzzy = {
        sorts = { 'exact', 'score', 'sort_text' },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
