return {
  'saghen/blink.cmp',
  event = { 'BufReadPost', 'BufNewFile' },
  version = '1.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    completion = {
      accept = { auto_brackets = { enabled = true } }, -- also need autopairs.nvim
      keyword = { range = 'full' },
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        enabled = true,
        auto_show = true,
        scrollbar = false,
        draw = {
          -- nvim-cmp style menu
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        treesitter_highlighting = true,
      },
      ghost_text = { enabled = true },
    },
    keymap = {
      preset = 'none',
      -- use tab s-tab or up down to select items
      -- enter to accept selected item

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<CR>'] = { 'accept', 'fallback' }, -- 更改成'select_and_accept'会选择第一项插入

      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' }, -- 同时存在补全列表和snippet时，补全列表选择优先级更高
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
    },
    signature = {
      enabled = true,
    },
    sources = {
      -- for lazydev plugin
      default = { 'lsp', 'buffer', 'snippets', 'path' },
      providers = {

        -- disable the completions when the keyword, for the first argument, is less than 3 characters.
        cmdline = {
          min_keyword_length = function(ctx)
            -- when typing a command, only show when the keyword is 3 characters or longer
            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
              return 3
            end
            return 0
          end,
        },
      },
    },

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      nerd_font_variant = 'Nerd Font',
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
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
  },
  opts_extend = { 'sources.default' },
}
