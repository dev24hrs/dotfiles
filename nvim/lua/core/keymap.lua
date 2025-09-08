vim.g.mapleader = ' '

-- Cancel s default function
vim.keymap.set({ 'n', 'v' }, 's', '', { noremap = true, silent = true, desc = 'Cancel [s] default function' })
vim.keymap.set({ 'n', 'v' }, 'a', '', { noremap = true, silent = true, desc = 'Cancel [a] default function' })
vim.keymap.set({ 'n', 'v' }, '^', '', { noremap = true, silent = true, desc = 'Cancel [^] default function' })
vim.keymap.set({ 'n', 'v' }, '$', '', { noremap = true, silent = true, desc = 'Cancel [$] default function' })

-- vim.keymap.set(
--   { 'i' },
--   'C-H',
--   '',
--   { noremap = true, silent = true, desc = 'Cancel [C-H] default function in insert model' }
-- )
-- vim.keymap.set(
--   { 'i' },
--   'C-L',
--   '',
--   { noremap = true, silent = true, desc = 'Cancel [C-L] default function in insert model' }
-- )
-- vim.keymap.set(
--   { 'i' },
--   'C-J',
--   '',
--   { noremap = true, silent = true, desc = 'Cancel [C-J] default function in insert model' }
-- )

-- Indent code in visual mode
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true, desc = 'Indent code in visual mode' })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true, desc = 'Indent code in visual mode' })

-- 选中后向下移动一行
vim.api.nvim_set_keymap(
  'v',
  'J',
  ":m '>+1<CR>gv=gv",
  { noremap = true, silent = true, desc = 'move selected line down' }
)
-- 选中后向上移动一行
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'move selected line up' })

-- 移动光标到行首
vim.keymap.set({ 'n', 'v' }, 'H', '^', { noremap = true, silent = true, desc = 'move cursor to line head' })

-- 移动光标到行尾
vim.keymap.set({ 'n', 'v' }, 'L', '$', { noremap = true, silent = true, desc = 'move cursor to line end' })

-- Buffers.
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<cr>', { noremap = true, silent = true, desc = 'Close buffer' })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.api.nvim_set_keymap(
  'n',
  '<leader>bp',
  ':bprevious<cr>',
  { noremap = true, silent = true, desc = 'Previous buffer' }
)
