---@diagnostic disable: missing-fields
return {
  {
    'LintaoAmons/cd-project.nvim',
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
      vim.api.nvim_set_keymap('n', '<leader>p', ':CdProject<CR>', { noremap = true, silent = true, desc = 'CdProject' })
    end,
  },
}