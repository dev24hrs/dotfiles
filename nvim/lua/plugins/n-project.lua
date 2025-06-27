return {
  'ahmedkhalf/project.nvim',

  config = function()
    require('project_nvim').setup({})

    -- with fzf-lua
    local history = require('project_nvim.utils.history')
    local project = require('project_nvim.project')

    vim.api.nvim_create_user_command('FzfProjects', function()
      local projects = history.get_recent_projects()

      require('fzf-lua').fzf_exec(projects, {
        prompt = 'Projects> ',
        actions = {
          ['default'] = function(selected)
            if selected and #selected > 0 then
              local project_path = selected[1]
              if project.set_pwd(project_path, 'fzf-lua') then
                require('fzf-lua').files()
              end
            end
          end,
        },
      })
    end, { desc = '[F]ind [P]rojects' })

    vim.keymap.set('n', '<leader>fp', '<cmd>FzfProjects<CR>', { desc = '[F]ind [P]rojects' })
  end,
}
