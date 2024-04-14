vim.g.mapleader = ' '

-- Cancel s default function
vim.api.nvim_set_keymap('n', 's', '', { noremap = true, silent = true, desc = 'Cancel s default function' })
vim.api.nvim_set_keymap('n', 'a', '', { noremap = true, silent = true, desc = 'Cancel a default function' })

-- Indent code in visual mode  liek TAB  & S-TAB
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

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<cr>', { noremap = true, silent = true, desc = 'Close buffer' })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<cr>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.api.nvim_set_keymap(
  'n',
  '<leader>bp',
  ':bprevious<cr>',
  { noremap = true, silent = true, desc = 'Previous buffer' }
)

-- Windows split screen shortcuts
vim.api.nvim_set_keymap('n', 'sv', ':vsp<CR>', { noremap = true, silent = true, desc = 'Vertical split' })
-- vim.api.nvim_set_keymap('n', 'sh', ':sp<CR>', { noremap = true, silent = true, desc = 'Horizontal split' })

-- Close current
vim.api.nvim_set_keymap('n', 'sc', '<C-w>c', { noremap = true, silent = true, desc = 'Close split' })

-- hjkl jump between windows
vim.api.nvim_set_keymap('n', 'wh', '<C-w>h', { noremap = true, silent = true, desc = 'goto window left' })
vim.api.nvim_set_keymap('n', 'wl', '<C-w>l', { noremap = true, silent = true, desc = 'goto window right' })
-- vim.api.nvim_set_keymap('n', 'wj', '<C-w>j')
-- vim.api.nvim_set_keymap('n', 'wk', '<C-w>k')

vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true, silent = true, desc = 'beginning of line' })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true, silent = true, desc = 'ending of line' })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save' })

-- remap C-hjkl to left, right, up, down in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<LEFT>', { noremap = true, silent = true, desc = 'LEFT' })
vim.api.nvim_set_keymap('i', '<C-l>', '<RIGHT>', { noremap = true, silent = true, desc = 'RIGHT' })
vim.api.nvim_set_keymap('i', '<C-j>', '<DOWN>', { noremap = true, silent = true, desc = 'DOWN' })
vim.api.nvim_set_keymap('i', '<C-k>', '<UP>', { noremap = true, silent = true, desc = 'UP' })
