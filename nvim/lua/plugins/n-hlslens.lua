return {
  'kevinhwang91/nvim-hlslens',
  event = 'VeryLazy',
  config = function()
    require('hlslens').setup({
      calm_down = true,
      -- nearest_only = true,
    })
    vim.api.nvim_set_keymap(
      'n',
      'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      { noremap = true, silent = true, desc = 'Prev Search Word' }
    )
    vim.api.nvim_set_keymap(
      'n',
      'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      { noremap = true, silent = true, desc = 'Next Search Word' }
    )

    -- use n or N or * or # to jump to next or prev
    local desc = { noremap = true, silent = true, desc = 'Search Word with nvim-hlslens' }
    vim.api.nvim_set_keymap('n', '*', [[<Cmd>lua require('hlslens').start()<CR>]], desc)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], desc)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], desc)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], desc)
  end,
}
