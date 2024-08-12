return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup({})
    require('telescope').load_extension('projects')
    vim.api.nvim_set_keymap(
      'n',
      '<leader>cp',
      '<cmd>Telescope projects<CR>',
      { noremap = true, silent = true, desc = '[C]d [P]roject' }
    )
  end,
}
