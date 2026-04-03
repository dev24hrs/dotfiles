vim.pack.add({
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

vim.keymap.set("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { silent = true })
