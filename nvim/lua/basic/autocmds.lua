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
    -- 2 空格 (前端/配置类)
    -- javascript = { 2, true },
    -- typescript = { 2, true },
    html = { 2, true },
    css = { 2, true },
    json = { 2, true },
    yaml = { 2, true },
    markdown = { 2, true },
    -- 4 空格 (真 Tab)
    go = { 4, false },
    -- 4 空格 (默认/后端)
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

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
    pattern = {
        'help',
        'lspinfo',
        'man',
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
