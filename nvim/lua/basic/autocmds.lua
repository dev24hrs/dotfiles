-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight copying text",
    group = vim.api.nvim_create_augroup("User_HighlightYank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 500 })
    end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

-- go to last position when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.list = false
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.conceallevel = 0
    end,
})

-- 注册 :PackClean
vim.api.nvim_create_user_command("PackClean", function()
    local unused_plugins = {}

    for _, p in ipairs(vim.pack.get()) do
        if not p.active then
            table.insert(unused_plugins, p.spec.name)
        end
    end

    if #unused_plugins == 0 then
        return print("No unused plugins found.")
    end

    print("Detected unused plugins: " .. table.concat(unused_plugins, ", "))

    if vim.fn.confirm("Delete these plugins from disk?", "&Yes\n&No", 2) == 1 then
        vim.pack.del(unused_plugins)
        print("Cleaned successfully.")
    else
        print("Cleaned canceled.")
    end
end, {})

-- 注册 :PackUpdate
vim.api.nvim_create_user_command("PackUpdate", function()
    local plugins_to_update = {}

    for _, p in ipairs(vim.pack.get()) do
        if p.active then
            table.insert(plugins_to_update, p.spec.name)
        end
    end

    if #plugins_to_update == 0 then
        return print("No active plugins to update.")
    end

    vim.pack.update(plugins_to_update)
end, {})

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.system({ "make" }, { cwd = ev.data.path })
        end
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close specific buffers with <q>",
    group = vim.api.nvim_create_augroup("User_CloseWithQ", { clear = true }),
    pattern = {
        "help",
        "lspinfo",
        "man",
        "qf",
        "notify",
        "checkhealth",
        "spectre_panel",
        "confirm",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- 大文件优化：禁用重负载功能
-- BufReadPre: 文件读取前检查大小，立即关闭 syntax/fold/swap/undo
vim.api.nvim_create_autocmd("BufReadPre", {
    desc = "Disable heavy features for large files",
    group = vim.api.nvim_create_augroup("User_BigFile", { clear = true }),
    callback = function(ev)
        local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(ev.buf))
        if size > vim.g.bigfile_size then
            vim.b[ev.buf].large_file = true
            vim.opt_local.syntax = "off"
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.swapfile = false
            vim.opt_local.undofile = false
            vim.opt_local.list = false
            vim.notify("Large file detected, heavy features disabled", vim.log.levels.WARN)
        end
    end,
})

-- LspAttach: 拦截 LSP 挂载事件，大文件直接 detach
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Detach LSP from large files",
    group = vim.api.nvim_create_augroup("User_BigFileLsp", { clear = true }),
    callback = function(ev)
        if vim.b[ev.buf].large_file then
            vim.schedule(function()
                vim.lsp.buf_detach_client(ev.buf, ev.data.client_id)
            end)
        end
    end,
})

-- BufReadPost: treesitter 加载后停掉它
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Stop treesitter for large files",
    group = vim.api.nvim_create_augroup("User_BigFileTs", { clear = true }),
    callback = function(ev)
        if vim.b[ev.buf].large_file then
            pcall(vim.treesitter.stop, ev.buf)
        end
    end,
})

-- 创建 :H 命令，在新的竖屏中打开 help
vim.api.nvim_create_user_command("H", function(opts)
    vim.cmd("vertical help " .. (opts.args ~= "" and opts.args or ""))
end, { nargs = "*", complete = "help" })
