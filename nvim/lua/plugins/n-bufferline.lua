local normal_bg = '#282828'
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      -- 数字显示：none（简洁）或 ordinal（1,2,3）
      numbers = 'ordinal',
      themable = true,

      close_command = function(bufnr)
        local listed_bufs = vim.tbl_filter(function(b)
          return vim.bo[b].buflisted and vim.bo[b].buftype == ''
        end, vim.api.nvim_list_bufs())

        if #listed_bufs > 1 then
          vim.cmd('bdelete! ' .. bufnr)
        else
          vim.cmd('enew')
          vim.cmd('bdelete! ' .. bufnr)
        end
      end,

      right_mouse_command = function(bufnr)
        local listed_bufs = vim.tbl_filter(function(b)
          return vim.bo[b].buflisted and vim.bo[b].buftype == ''
        end, vim.api.nvim_list_bufs())

        if #listed_bufs > 1 then
          vim.cmd('bdelete! ' .. bufnr)
        else
          vim.cmd('enew')
          vim.cmd('bdelete! ' .. bufnr)
        end
      end,
      indicator_icon = '',
      buffer_close_icon = '',
      close_icon = '',
      modified_icon = '',
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      left_mouse_command = 'buffer %d',
      middle_mouse_command = nil,
      separator_style = 'thin',
      always_show_bufferline = true,
      tab_size = 16,
      show_tab_indicators = false,

      diagnostics = 'nvim_lsp',
    },
    highlights = {
      fill = {
        bg = normal_bg,
      },
      background = {
        bg = normal_bg,
      },
      buffer_visible = {
        bg = normal_bg,
      },
      buffer_selected = {
        bg = normal_bg,
        bold = true,
        italic = false,
      },
      separator = {
        bg = normal_bg,
      },
      separator_selected = {
        fg = normal_bg,
        bg = normal_bg,
      },
      separator_visible = {
        fg = normal_bg,
        bg = normal_bg,
      },
      numbers = {
        bg = normal_bg,
      },
      numbers_visible = {
        bg = normal_bg,
      },
      numbers_selected = {
        bg = normal_bg,
        bold = true,
        italic = true,
      },
      modified = {
        fg = '#fb4934',
        bg = normal_bg,
      },
      modified_visible = {

        fg = '#fb4934',
        bg = normal_bg,
      },
      modified_selected = {
        fg = '#fb4934',
        bg = normal_bg,
      },
    },
  },
}
