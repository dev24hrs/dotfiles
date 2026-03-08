return {
    'j-hui/fidget.nvim',
    version = '*',
    -- event = 'VeryLazy',
    event = 'LspAttach',
    opts = {
        progress = {
            display = {
                done_icon = '󰄬', -- 任务完成后的图标
                progress_ttl = 3, -- 完成后保留 3 秒
            },
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
