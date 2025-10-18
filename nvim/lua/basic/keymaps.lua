vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Indent code in visual mode
vim.api.nvim_set_keymap(
  'v',
  '<',
  '<gv',
  { noremap = true, silent = true, desc = '[Basic]: Indent code in visual mode' }
)
vim.api.nvim_set_keymap(
  'v',
  '>',
  '>gv',
  { noremap = true, silent = true, desc = '[Basic]: Indent code in visual mode' }
)

-- 选中后向下移动一行
vim.api.nvim_set_keymap(
  'v',
  'J',
  ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = 'move selected line down' }
)
-- 选中后向上移动一行
vim.api.nvim_set_keymap(
  'v',
  'K',
  ":m '<-2<CR>gv=gv",
  { noremap = true, silent = true, desc = '[Basic]: move selected line up' }
)

-- move cursor to line head or end
vim.keymap.set({ 'n', 'v' }, 'H', '^', { noremap = true, silent = true, desc = '[Basic]: move cursor to line head' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { noremap = true, silent = true, desc = '[Basic]: move cursor to line end' })
