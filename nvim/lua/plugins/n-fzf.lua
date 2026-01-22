return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('fzf-lua').setup({
      winopts = {
        border = 'single',
        height = 0.85,
        width = 0.80,
        row = 0.45,
        col = 0.50,
        preview = {
          wrap = true,
          scrollbar = false,
        },
      },
      fzf_colors = true,
    })

    --NOTE: fzf-lua

    --[[
    setup for 2 using case
    1.one is for codecompanion.nvim or avante.nvim, all of them can use fzf-lua as default picker selector
        when i using these 2 plugins, want to change adapters in codecompanion chat buff with ga keybinding or choose files in avante chat
        buffer with @ keybinding, the selector window is not fzf ui window.
        about this problem, i think it may be that they used vim.ui.selector in the new generated selection window of the chat buffer,not fzf ui selector .im not good at lua,so I can't be sure.
    2.one is for using FzfLua lsp_code_actions,i got the msg : " FzfLua is not currently registered as 'vim.ui.select' backend,
        use 'silent=true' to hide this message or register globally using ':FzfLua register_ui_select'"
    3.i attempted to using ":FzfLua register_ui_select ",it works. but when i quit neoivm session and restart, i still got the msg.
    others fzf cmd is ok.
 ]]
    vim.cmd('FzfLua register_ui_select')
    -- require('fzf-lua').register_ui_select({
    --   winopts = {
    --     width = 0.6,
    --     height = 0.5,
    --     row = 0.50, -- window row position (0=top, 1=bottom)
    --     col = 0.50, -- window col position (0=left, 1=right)
    --   },
    -- })

    vim.keymap.set('n', '<leader>fl', function()
      require('fzf-lua').files()
    end, { noremap = true, silent = true, desc = '[Fzf]: Files List in project' })

    vim.keymap.set('n', '<leader>fw', function()
      require('fzf-lua').lgrep_curbuf()
    end, { noremap = true, silent = true, desc = '[Fzf]: Find Word in current buffer' })

    vim.keymap.set('n', '<leader>fg', function()
      require('fzf-lua').live_grep()
    end, { noremap = true, silent = true, desc = '[Fzf]: Find Grep words in project' })

    vim.keymap.set('n', '<leader>fr', function()
      require('fzf-lua').oldfiles()
    end, { noremap = true, silent = true, desc = '[Fzf]: Find Recent files' })

    vim.keymap.set('n', '<leader>fc', function()
      require('fzf-lua').files({ cwd = '~/.config/nvim' })
    end, { noremap = true, silent = true, desc = '[Fzf]: Find in neovim Configuration' })

    vim.keymap.set('n', '<leader>fb', function()
      require('fzf-lua').buffers()
    end, { noremap = true, silent = true, desc = '[Fzf]: Find existing Buffers' })

    vim.keymap.set('n', '<leader>sk', function()
      require('fzf-lua').keymaps()
    end, { noremap = true, silent = true, desc = '[Fzf]: Show Keymaps' })

    vim.keymap.set('n', '<leader>sh', function()
      require('fzf-lua').helptags()
    end, { noremap = true, silent = true, desc = '[Fzf]: Show Neovim Help Pages' })

    vim.keymap.set('n', '<leader>sq', function()
      require('fzf-lua').lgrep_quickfix()
    end, { noremap = true, silent = true, desc = '[Fzf]: Show Quickfix List current buffer' })

    -- lsp code actions
    vim.keymap.set('n', '<leader>ca', function()
      require('fzf-lua').lsp_code_actions()
    end, { noremap = true, silent = true, desc = '[Fzf]: Lsp Code Actions' })
  end,
}
