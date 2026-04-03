vim.pack.add({
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/3rd/image.nvim" },
})
require("image").setup({
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
        markdown = {
            enabled = true,
            clear_in_insert_mode = true,
        },
    },
})

require("render-markdown").setup({
    file_types = { "markdown" },
    latex = { enabled = false },
    sign = { enabled = true },
    code = {
        sign = true,
        language = false,
        render_modes = true,
        style = "language",
    },
    heading = {
        icons = { " 󰬺 ", " 󰬻 ", " 󰬼 ", " 󰬽 ", " 󰬾 ", " 󰬿 " },
        position = "inline",
        border = false,
        render_modes = true, -- keep rendering while inserting
    },
    bullet = {
        enabled = true,
        render_modes = false,
        icons = { "", "", "", "" },
    },
    checkbox = {
        enabled = true,
        render_modes = false,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
            scope_highlight = nil,
        },
        checked = {
            icon = "󰱒 ",
            highlight = "RenderMarkdownChecked",
            scope_highlight = nil,
        },
        custom = {
            todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
        scope_priority = nil,
    },
    pipe_table = {
        -- preset = 'round',
        alignment_indicator = "─",
        border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
    },
    link = {
        render_modes = false,
        wiki = { icon = " ", highlight = "RenderMarkdownWikiLink", scope_highlight = "RenderMarkdownWikiLink" },
        image = " ",
        custom = {
            github = { pattern = "github", icon = " " },
            cern = { pattern = "cern.ch", icon = " " },
        },
        hyperlink = " ",
    },
    anti_conceal = {
        disabled_modes = { "n" },
        ignore = {
            bullet = false, -- render bullet in insert mode
            head_border = true,
            head_background = true,
        },
    },
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
    win_options = { concealcursor = { rendered = "nvc" } },

    completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
    },
})
