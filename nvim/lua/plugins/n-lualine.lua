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
      red = '#fb4934',
      gray = '#a89984',
      darkgray = '#3c3836',
    }
    custom_gruvbox = {
      normal = {
        a = { bg = colors.darkgray, fg = colors.red },
        b = { bg = colors.darkgray, fg = colors.gray },
        c = { bg = colors.darkgray, fg = colors.gray },
        x = { bg = colors.darkgray, fg = colors.gray },
        y = { bg = colors.darkgray, fg = colors.gray },
        z = { bg = colors.darkgray, fg = colors.red },
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
          -- '%3{codeium#GetStatusString()}',
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
