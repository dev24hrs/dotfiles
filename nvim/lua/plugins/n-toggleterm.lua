return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup({
      open_mapping = [[<c-/>]],
      shading_factor = '1',
      direction = 'float',
      size = 20,
      -- direction = 'horizontal',
      -- size = 15,
      float_opts = {
        border = 'single',
      },
    })
    -- local Terminal = require('toggleterm.terminal').Terminal
    -- local lazygit = Terminal:new({
    --   cmd = 'lazygit',
    --   dir = 'git_dir',
    --   direction = 'float',
    --   float_opts = {
    --     border = 'single',
    --   },
    --   -- function to run on opening the terminal
    --   on_open = function(term)
    --     vim.cmd('startinsert!')
    --     vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    --   end,
    --   -- function to run on closing the terminal
    --   on_close = function()
    --     vim.cmd('startinsert!')
    --   end,
    -- })
    -- function _Lazygit_toggle()
    --   lazygit:toggle()
    -- end
    -- vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _Lazygit_toggle()<CR>', { noremap = true, silent = true })
  end,
}
