-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'highlight copying text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 500 })
    end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
    end,
})

-- go to last position when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

--- Go Mod Tidy 部分 ---
local go_tidy_group = vim.api.nvim_create_augroup('GoModTidy', { clear = true })
local last_tidy_time = 0

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'go.mod', 'go.sum' }, -- 增加对 go.sum 的监听
    group = go_tidy_group,
    callback = function()
        -- 1. 防抖处理：5秒内只允许触发一次，避免频繁保存导致系统卡顿
        local now = os.time()
        if now - last_tidy_time < 5 then
            return
        end
        last_tidy_time = now

        -- 2. 检查 go 命令行工具是否存在
        if vim.fn.executable('go') ~= 1 then
            return
        end

        -- 3. 使用异步任务并添加简单的成功/失败通知
        vim.fn.jobstart('go mod tidy', {
            detach = true,
            on_exit = function(_, exit_code)
                if exit_code == 0 then
                    vim.notify('go mod tidy finished', vim.log.levels.INFO, { title = 'Go Tools' })
                else
                    vim.notify('go mod tidy failed', vim.log.levels.ERROR, { title = 'Go Tools' })
                end
            end,
        })
    end,
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'go',
    callback = function()
        vim.opt_local.list = false -- 仅在 Go 文件中关闭 listchars 显示
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.conceallevel = 0
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
    pattern = {
        'help',
        'lspinfo',
        'man',
        'qf',
        'notify',
        'checkhealth',
        'spectre_panel', -- config in /plugins/n-hlslens.lua
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

-- 创建 :H 命令，在新的竖屏中打开 help
vim.api.nvim_create_user_command('H', function(opts)
    vim.cmd('vertical help ' .. (opts.args ~= '' and opts.args or ''))
end, { nargs = '*', complete = 'help' })
