vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Indent code in visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true, desc = '[Basic]: Indent code in visual mode' })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true, desc = '[Basic]: Indent code in visual mode' })

-- 行移动
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = '[Basic]: move selected line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = '[Basic]: move selected line up' })

-- move cursor to line head or end
vim.keymap.set({ 'n', 'v' }, 'H', '^', { noremap = true, silent = true, desc = '[Basic]: move cursor to line head' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { noremap = true, silent = true, desc = '[Basic]: move cursor to line end' })

vim.keymap.set('n', 'wc', '<C-w>c', { noremap = true, silent = true, desc = '[Basic]: Close split' })
vim.keymap.set('n', 'wh', '<C-w>h', { noremap = true, silent = true, desc = '[Basic]: move to left split' })
vim.keymap.set('n', 'wl', '<C-w>l', { noremap = true, silent = true, desc = '[Basic]: move to right split' })
vim.keymap.set('n', 'wj', '<C-w>j', { noremap = true, silent = true, desc = '[Basic]: move to right split' })
vim.keymap.set('n', 'wk', '<C-w>k', { noremap = true, silent = true, desc = '[Basic]: move to right split' })
