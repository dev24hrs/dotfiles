local HEIGHT_RATIO = 0.7 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

-- float window config
local function open_win_config_func()
  local screen_w = vim.opt.columns:get()
  -- local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local screen_h = vim.opt.lines:get()
  local window_w = screen_w * WIDTH_RATIO
  local window_h = screen_h * HEIGHT_RATIO
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  -- local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
  local center_y = ((vim.opt.lines:get() - window_h) / 2)
  return {
    border = 'single',
    relative = 'editor',
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
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
    vim.keymap.set('n', '<leader>e', api.tree.toggle, { desc = '[NvimTree]: Toggle Nvim Tree' })

    --  automatically resize the floating window when neovim's window size changes
    vim.api.nvim_create_augroup('NvimTreeResize', {
      clear = true,
    })
    vim.api.nvim_create_autocmd({ 'VimResized', 'WinResized' }, {
      group = 'NvimTreeResize',
      callback = function()
        -- Get the nvim-tree window ID
        local winid = api.tree.winid()
        if winid then
          api.tree.reload()
        end
      end,
    })
    local function edit_or_open()
      local node = api.tree.get_node_under_cursor()

      if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
      else
        -- open file
        api.node.open.edit()
        -- Close the tree if file was opened
        api.tree.close()
      end
    end
    -- custom needed keymap
    local function on_my_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', 'l', edit_or_open, opts('[NvimTree]: Edit Or Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('[NvimTree]: Close'))
      -- del map for '-' and 's'
      vim.keymap.set('n', '-', '', opts('[NvimTree]: cancel - '))
      vim.keymap.set('n', 's', '', opts('[NvimTree]: cancel s '))
    end

    require('nvim-tree').setup({
      on_attach = on_my_attach,
      view = {
        signcolumn = 'yes',
        float = {
          enable = true,
          open_win_config = open_win_config_func,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
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
          symlink_arrow = '󱦰',
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
