return {
  'kawre/leetcode.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    arg = 'leetcode.nvim',
    lang = 'golang',
    cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = true, ---@type boolean
      translate_problems = true, ---@type boolean
    },
    storage = {
      home = vim.fn.expand('$HOME/Documents/Code/LeetCode'),
      cache = vim.fn.expand('$HOME/Documents/Code/LeetCode/.cache'),
    },
    picker = { provider = 'snacks-picker' },
    injector = {},
  },
}
