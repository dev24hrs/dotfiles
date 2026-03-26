vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function map(mode, lhs, rhs, desc)
    local options = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, options)
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>', '[Basic]: clear search highlight')

-- 在 Insert 模式下按下 Esc，退回到 Normal 模式并保存（仅在文件有修改时保存）
-- map('i', '<Esc>', '<Esc>:update<CR>')

-- 在 Insert 模式下按 Shift + Tab 向后缩进 (Outdent)
map('i', '<S-Tab>', '<C-d>', '[Basic]: Outdent code in insert mode')

-- Indent code in visual mode
map('v', '<', '<gv', '[Basic]: Indent code in visual mode')
map('v', '>', '>gv', '[Basic]: Indent code in visual mode')

-- 行移动
map('v', 'J', ":m '>+1<CR>gv=gv", '[Basic]: move selected line down')
map('v', 'K', ":m '<-2<CR>gv=gv", '[Basic]: move selected line up')

-- move cursor to line head or end
map({ 'n', 'v' }, 'W', '^', '[Basic]: move cursor to line head')
map({ 'n', 'v' }, 'E', '$', '[Basic]: move cursor to line end')

-- -- buffer switch
map('n', '<S-l>', '<cmd>bnext<CR>', '[Basic]: buffer next')
map('n', '<S-h>', '<cmd>bprevious<CR>', '[Basic]: buffer previous')
map('n', 'bd', '<cmd>bdelete!<CR>', '[Basic]: buffer close')

map('n', 'vw', 'viw', '[Basic]: selecte current word')
map('n', 'vv', 'V', '[Basic]: selecte whole line')

-- move cursor to line head or end
-- map({ 'n', 'v' }, 'H', '^', '[Basic]: move cursor to line head')
-- map({ 'n', 'v' }, 'L', '$', '[Basic]: move cursor to line end')
--
-- map('n', 'wc', '<C-w>c', '[Basic]: Close split')
-- map('n', 'wh', '<C-w>h', '[Basic]: move to left split')
-- map('n', 'wl', '<C-w>l', '[Basic]: move to right split')
-- map('n', 'wj', '<C-w>j', '[Basic]: move to right split')
-- map('n', 'wk', '<C-w>k', '[Basic]: move to right split')
--
-- -- buffer switch
-- map('n', '<C-n>', '<cmd>bnext<CR>', '[Basic]: buffer next')
-- map('n', '<C-p>', '<cmd>bprevious<CR>', '[Basic]: buffer previous')
-- map('n', '<C-c>', '<cmd>bdelete!<CR>', '[Basic]: buffer close')
