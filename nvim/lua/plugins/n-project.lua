---@diagnostic disable: missing-fields
return {
  {
    'LintaoAmons/cd-project.nvim',
    event = 'VeryLazy',
    config = function()
      require('cd-project').setup({
        projects_picker = 'telescope', -- optional, you can switch to `telescope`
        hooks = {
          {
            callback = function(_)
              vim.cmd('Telescope fd')
            end,
          },
        },
      })
      vim.api.nvim_set_keymap(
        'n',
        '<leader>cp',
        ':CdProject<CR>',
        { noremap = true, silent = true, desc = '[C]d [P]roject' }
      )
    end,
  },
}
