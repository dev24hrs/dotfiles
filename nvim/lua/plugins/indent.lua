vim.pack.add({
    { src = "https://github.com/shellRaining/hlchunk.nvim" },
})

require("hlchunk").setup({
    chunk = {
        enable = true,
        style = { { fg = "#806d9c" } },
    },
    indent = {
        enable = true,
        chars = {
            "│",
        },
    },
    line_num = { enable = false },
    blank = { enable = false },
})
