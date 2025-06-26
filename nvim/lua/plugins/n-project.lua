return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup({})
    require('telescope').load_extension('projects')
    vim.api.nvim_set_keymap(
      'n',
      '<leader>fp',
      '<cmd>Telescope projects<CR>',
      { noremap = true, silent = true, desc = '[F]ind [P]rojects' }
    )
  end,
}
