return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
          },
        },
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            preview_height = 0.5,
            size = {
              width = '90%',
              height = '90%',
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
        file_browser = {
          theme = 'dropdown',
          hijack_netrw = true,
        },
      },
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, { desc = '[F]ind [W]ords in Current buffer' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind Words by [G]rep in all buffers' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]how [B]uffers' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]how [K]eymaps' })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('file_browser')
    -- require('telescope').load_extension('dap')
  end,
}
