-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'highlight copying text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
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

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    pattern = '*',
    command = 'set cursorline',
    group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    pattern = '*',
    command = 'set nocursorline',
    group = cursorGrp,
})
-- set indent by file type
local function set_indent(size, expand_tab)
    vim.opt_local.tabstop = size -- Tab 显示的宽度
    vim.opt_local.shiftwidth = size -- 缩进的宽度
    vim.opt_local.softtabstop = size -- 按退格键时删除的空格数
    vim.opt_local.expandtab = expand_tab -- 是否将 Tab 转为空格
end

local indent_group = vim.api.nvim_create_augroup('LanguagesIndent', { clear = true })

local lang_map = {
    -- javascript = { 2, true },
    -- typescript = { 2, true },
    -- html = { 2, true },
    -- css = { 2, true },
    json = { 2, true },
    jsonc = { 2, true },
    yaml = { 2, true },
    markdown = { 2, true },
    sh = { 2, true },
    toml = { 2, true },
    sql = { 2, true },
    -- 4 空格 (真 Tab)
    go = { 4, false },
    python = { 4, true },
    lua = { 4, true },
    c = { 4, true },
    cpp = { 4, true },
    rust = { 4, true },
}
vim.api.nvim_create_autocmd('FileType', {
    pattern = vim.tbl_keys(lang_map),
    group = indent_group,
    callback = function(args)
        local config = lang_map[args.match]
        if config then
            set_indent(config[1], config[2])
        end
    end,
})
-- -- tidy go.mod
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     pattern = 'go.mod',
--     callback = function()
--         vim.fn.jobstart('go mod tidy', { detach = true })
--     end,
-- })

--- 优化后的 Go Mod Tidy 部分 ---
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
