return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup({})

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd file' })

    vim.keymap.set('n', '<leader>hl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[H]arpoon [L]ist files' })

    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = '[H]arpoon [P]revious file' })

    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = '[H]arpoon [N]ext file' })

    -- basic telescope configuration

    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --     .new({}, {
    --       prompt_title = 'Harpoon',
    --       finder = require('telescope.finders').new_table({
    --         results = file_paths,
    --       }),
    --       previewer = conf.file_previewer({}),
    --       sorter = conf.generic_sorter({}),
    --     })
    --     :find()
    -- end
    --
    -- vim.keymap.set('n', '<leader>fh', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = '[H]arpoon List [F]iles' })
  end,
}
