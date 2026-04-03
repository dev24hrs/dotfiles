vim.pack.add({
    { src = "https://github.com/numToStr/Comment.nvim" },
})

require("Comment").setup({
    padding = true,
    sticky = true,
    mappings = {
        basic = false,
        extra = false,
    },
})

local api = require("Comment.api")
vim.keymap.set("n", "<C-.>", function()
    api.locked("comment.linewise.current")()
end, { desc = "[Comment]: Comment line" })

vim.keymap.set("n", "<C-;>", function()
    api.locked("uncomment.linewise.current")()
end, { desc = "[Comment]: Uncomment line" })

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
vim.keymap.set("x", "<C-.>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "[Comment]: Comment linewise" })

vim.keymap.set("x", "<C-;>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "[Comment]: Uncomment linewise" })

vim.keymap.set("x", "<C-\\>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("toggle.blockwise")(vim.fn.visualmode())
end, { desc = "[Comment]: Comment/Uncomment blockwise" })
