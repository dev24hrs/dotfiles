---@diagnostic disable: undefined-field
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- 'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.icons',
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
    require('lualine').setup({
      options = {
        theme = 'auto',
        component_separators = '|',
      },
      sections = {
        lualine_a = { { 'mode', icons_enabled = true } },
        lualine_b = {
          { 'branch', icon = '' },
          {
            'diff',
            symbols = { added = '+', modified = '~', removed = '-' },
            source = diff_source,
          },
          {
            'filename',
            file_status = true,
            path = 1,
            symbols = { modified = ' [+]', readonly = ' ', unnamed = '', newfile = '[New]' },
          },
        },

        lualine_c = { 'encoding' },
        lualine_x = {},
        lualine_y = {
          { '%3{codeium#GetStatusString()}' },
          {
            'fileformat',
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
          { 'filetype', colored = true, icon_only = false, icon = { align = 'left' } },
        },
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
