vim.pack.add({
    { src = "https://github.com/nvimdev/lspsaga.nvim" },
})

require("lspsaga").setup({
    ui = {
        border = "rounded",
        code_action = "",
        actionfix = "",
        imp_sign = "󰳛 ",
    },
    implement = {
        enable = true,
        sign = true,
        virtual_text = true,
        priority = 100,
    },
    lightbulb = {
        enable = false,
        sign = false,
    },
    code_action = {
        show_server_name = true,
        extend_gitsigns = true,
        keys = { quit = "q", exec = "<CR>" },
    },
    symbol_in_winbar = { enable = false, hide_keyword = true, show_file = true, folder_level = 0 },
    outline = { enable = false },
    diagnostic = {
        extend_relatedInformation = true,
        show_layout = "float",
        max_show_width = 0.7,
        max_width = 0.7,
        keys = {
            exec_action = "o",
            quit = "q",
            go_action = "<CR>",
            quit_in_show = { "q", "<ESC>" },
        },
    },
    hover = {
        max_width = 0.7,
        max_height = 0.6,
        open_link = "o", -- key for opening links
    },
})
