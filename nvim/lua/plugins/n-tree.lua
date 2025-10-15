local function open_win_config_func()
  local scr_w = vim.opt.columns:get()
  local scr_h = vim.opt.lines:get()
  local tree_w = 80
  local tree_h = math.floor(tree_w * scr_h / scr_w)
  return {
    border = 'double',
    relative = 'editor',
    width = tree_w,
    height = tree_h,
    col = (scr_w - tree_w) / 2,
    row = (scr_h - tree_h) / 2,
  }
end

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local api = require('nvim-tree.api')
    vim.keymap.set('n', '<leader>e', api.tree.toggle, { desc = '[T]oggle [N]vim [T]ree' })
    require('nvim-tree').setup({
      view = {
        signcolumn = 'yes',
        float = {
          enable = true,
          open_win_config = open_win_config_func,
        },
        cursorline = false,
      },
      modified = {
        enable = true,
      },
      sort = {
        sorter = 'name',
        folders_first = true,
        files_first = false,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '󱦰',
              arrow_open = '󱦳',
            },
          },
        },
      },
      filters = {
        git_ignored = false,
      },
      hijack_cursor = true,
      sync_root_with_cwd = true,
    })
  end,
}
