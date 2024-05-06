return {
  'roobert/search-replace.nvim',
  event = 'VeryLazy',
  config = function()
    require('search-replace').setup({
      -- optionally override defaults
      default_replace_single_buffer_options = 'gcI',
      default_replace_multi_buffer_options = 'egcI',
    })
    local opts = { noremap = true, silent = true, desc = 'Search and Replace word' }
    -- replace selected text in visual mode
    vim.api.nvim_set_keymap('v', '<leader>rp', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>', opts)
    -- replace text in normal mode
    vim.api.nvim_set_keymap('n', '<leader>rs', '<CMD>SearchReplaceSingleBufferOpen<CR>', opts)
    -- replace word under cursor
    vim.api.nvim_set_keymap('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWORD<CR>', opts)
    -- replace file under cursor
    vim.api.nvim_set_keymap('n', '<leader>rf', '<CMD>SearchReplaceSingleBufferCFile<CR>', opts)

    -- show the effects of a search / replace in a live preview window
    vim.o.inccommand = 'split'
  end,
}
