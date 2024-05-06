---@diagnostic disable: undefined-field
return {
  'nvim-lualine/lualine.nvim',
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
        lualine_x = {
          {
            -- Lsp server name .
            function()
              local msg = 'No Active Lsp'
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            -- icon = '',
          },
        },
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
