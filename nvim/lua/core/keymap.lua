vim.g.mapleader = ' '

-- Cancel s default function
vim.keymap.set({ 'n', 'v' }, 's', '', { noremap = true, silent = true, desc = 'Cancel [s] default function' })
vim.keymap.set({ 'n', 'v' }, 'a', '', { noremap = true, silent = true, desc = 'Cancel [a] default function' })
vim.keymap.set({ 'n', 'v' }, '^', '', { noremap = true, silent = true, desc = 'Cancel [^] default function' })
vim.keymap.set({ 'n', 'v' }, '$', '', { noremap = true, silent = true, desc = 'Cancel [$] default function' })

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

-- Windows split screen shortcuts
vim.api.nvim_set_keymap('n', 'sv', ':vsp<CR>', { noremap = true, silent = true, desc = 'Vertical split' })
-- vim.api.nvim_set_keymap('n', 'sh', ':sp<CR>', { noremap = true, silent = true, desc = 'Horizontal split' })
vim.api.nvim_set_keymap('n', 'sc', '<C-w>c', { noremap = true, silent = true, desc = 'Close split' })

-- hjkl jump between windows
vim.api.nvim_set_keymap('n', 'wh', '<C-w>h', { noremap = true, silent = true, desc = 'goto window left' })
vim.api.nvim_set_keymap('n', 'wl', '<C-w>l', { noremap = true, silent = true, desc = 'goto window right' })
-- vim.api.nvim_set_keymap('n', 'wj', '<C-w>j')
-- vim.api.nvim_set_keymap('n', 'wk', '<C-w>k')

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save Current Buffer' })

-- remap C-hjkl to left, right, up, down in insert mode
-- if u set c-h/j/k/l in yabai & skhd, it will not work in neovim
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true, desc = 'Left in insert mode' })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true, desc = 'Right in insert mode' })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true, desc = 'Down in insert mode' })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true, desc = 'Up in insert mode' })
