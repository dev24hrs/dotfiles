return {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
        require('toggleterm').setup({
            open_mapping = [[<c-t>]],
            -- open_mapping = [[<leader>tl]],
            autochdir = true,
            shading_factor = '1',
            -- direction = 'horizontal',
            direction = 'float',
            size = 20,
            float_opts = {
                width = 100,
                height = 30,
                border = 'single',
            },
        })
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
}
