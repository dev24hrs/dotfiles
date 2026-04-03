vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function keymap(mode, lhs, rhs, desc)
    local options = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, options)
end

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", "[Basic]: clear search highlight")

keymap("i", "<S-Tab>", "<C-d>", "[Basic]: Outdent code in insert mode")

-- Indent code in visual mode
keymap("v", "<", "<gv", "[Basic]: Indent code in visual mode")
keymap("v", ">", ">gv", "[Basic]: Indent code in visual mode")

keymap("v", "J", ":m '>+1<CR>gv=gv", "[Basic]: move selected line down")
keymap("v", "K", ":m '<-2<CR>gv=gv", "[Basic]: move selected line up")

keymap({ "n", "v" }, "W", "^", "[Basic]: move cursor to line head")
keymap({ "n", "v" }, "E", "$", "[Basic]: move cursor to line end")

keymap("n", "wh", "<C-w>h", "[Basic]: move to left split")
keymap("n", "wl", "<C-w>l", "[Basic]: move to right split")

keymap("n", "<S-l>", "<cmd>bnext<CR>", "[Basic]: buffer next")
keymap("n", "<S-h>", "<cmd>bprevious<CR>", "[Basic]: buffer previous")
keymap("n", "bd", "<cmd>bdelete!<CR>", "[Basic]: buffer close")

-- 普通模式：注释 / 取消注释当前行
-- vim.keymap.set("n", "<C-;>", "gcc", { remap = true, desc = "Toggle comment line" })

-- 可视模式：注释 / 取消注释选中的代码块
-- vim.keymap.set("v", "<C-;>", "gc", { remap = true, desc = "Toggle comment block" })
