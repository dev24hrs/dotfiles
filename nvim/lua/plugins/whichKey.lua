vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("which-key").setup({
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
})

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "[WhichKey]: Buffer Local Keymaps" })
