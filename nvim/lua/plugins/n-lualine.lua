---@diagnostic disable: undefined-field
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end
    local custom_gruvbox = require('lualine.themes.gruvbox_dark')
    local colors = {
      MAGENTA = '#a89984',
      DARKGRAY = '#3e3d3d',
      RED = '#cb241d',
      GREEN = '#a9b665',
      YELLOW = '#d8a657',
      BLUE = '#7daea3',
      CYAN = '#89b482',
    }
    custom_gruvbox = {
      normal = {
        a = { bg = colors.DARKGRAY, fg = colors.RED },
        b = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
        c = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
        x = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
        y = { bg = colors.DARKGRAY, fg = colors.MAGENTA },
        z = { bg = colors.DARKGRAY, fg = colors.RED },
      },
    }

    require('lualine').setup({
      options = {
        theme = custom_gruvbox,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'branch', icon = '' },
          {
            'diff',
            symbols = { added = '+', modified = '~', removed = '-' },
            source = diff_source,
          },
          { 'diagnostics' },
        },

        lualine_c = {
          'filename',
        },
        lualine_x = {
          '%3{codeium#GetStatusString()}',
          'encoding',
          {
            'fileformat',
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
        },
        lualine_y = { 'filetype' },
        lualine_z = {
          {
            'lsp_status',
            icon = false,
            symbols = {
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              done = '✓',
              separator = ' ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            -- Display the LSP name
            show_name = true,
          },
        },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
