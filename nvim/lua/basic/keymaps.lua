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

vim.keymap.set('n', 's', '', { noremap = true, silent = true, desc = '[Basic]: cancel s default' })
vim.keymap.set('n', 'sv', ':vsp<CR>', { noremap = true, silent = true, desc = '[Basic]: Vertical split' })
vim.keymap.set('n', 'sh', ':sp<CR>', { noremap = true, silent = true, desc = '[Basic]: Horizontal split' })
vim.keymap.set('n', 'wc', '<C-w>c', { noremap = true, silent = true, desc = '[Basic]: Close split' })

-- if u prefer use C-hjkl to switch panes, use https://github.com/christoomey/vim-tmux-navigator
-- to swtich between vim and tmux panes

vim.keymap.set('n', 'wh', '<C-w>h', { noremap = true, silent = true, desc = '[Basic]: move to left split' })
vim.keymap.set('n', 'wl', '<C-w>l', { noremap = true, silent = true, desc = '[Basic]: move to right split' })
vim.keymap.set('n', 'wj', '<C-w>j', { noremap = true, silent = true, desc = '[Basic]: move to right split' })
vim.keymap.set('n', 'wk', '<C-w>k', { noremap = true, silent = true, desc = '[Basic]: move to right split' })

-- remap C-hjkl to left, right, up, down in insert mode

vim.keymap.set('i', '<C-h>', '<LEFT>', { noremap = true, silent = true, desc = '[Basic]: LEFT insert model' })
vim.keymap.set('i', '<C-l>', '<RIGHT>', { noremap = true, silent = true, desc = '[Basic]: RIGHT insert model' })
vim.keymap.set('i', '<C-j>', '<DOWN>', { noremap = true, silent = true, desc = '[Basic]: DOWN insert model' })
vim.keymap.set('i', '<C-k>', '<UP>', { noremap = true, silent = true, desc = '[Basic]: UP insert model' })
