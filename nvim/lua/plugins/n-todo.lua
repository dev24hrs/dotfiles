return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup({
      signs = false,
    })

    vim.keymap.set('n', ']t', function()
      require('todo-comments').jump_next()
    end, { desc = 'Next todo comment' })

    vim.keymap.set('n', '[t', function()
      require('todo-comments').jump_prev()
    end, { desc = 'Previous todo comment' })

    vim.keymap.set('n', '<leader>td', '<CMD>TodoFzfLua<CR>', { desc = '[S]how [T]oDo List' })

    -- 使用
    -- 关键词:
    -- FIX = { FIXME, BUG, FIXIT, ISSUE }
    -- TODO
    -- WARN
    -- NOTE = { INFO }
    -- TEST = { TESTING, PASSED, FAILED }
    --  以 '--' 开头+ 关键词, 紧跟: , 输入内容

    --TODO: do something
    --NOTE: note something
    --HACK: hack something
    --WARN: warn something
    --FIX: fix something
    --ISSUE: issue something
    --TEST: test something
  end,
}
