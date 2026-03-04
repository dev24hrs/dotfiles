return {
    'j-hui/fidget.nvim',
    version = '*',
    event = 'VeryLazy',
    opts = {
        progress = {
            suppress_on_insert = true,
            ignore_done_already = false,
            ignore_empty_message = true,
        },
        notification = {
            window = {
                winblend = 0,
                border = 'none',
            },
        },
    },
}
