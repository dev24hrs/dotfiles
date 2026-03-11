-- this file is for indent settings

local function set_indent(size, expand_tab)
    vim.opt_local.tabstop = size
    vim.opt_local.shiftwidth = size
    vim.opt_local.softtabstop = size
    vim.opt_local.expandtab = expand_tab
end

local indent_configs = {
    -- 2 空格缩进组
    {
        size = 2,
        expand = true,
        types = { 'json', 'jsonc', 'yaml', 'markdown', 'sh', 'toml', 'sql', 'gitcommit' },
    },
    -- 4 空格缩进组
    {
        size = 4,
        expand = true,
        types = { 'c', 'cpp', 'python', 'lua', 'rust' },
    },
    -- 4 物理 Tab 组
    {
        size = 4,
        expand = false,
        types = { 'go' },
    },
}

local indent_group = vim.api.nvim_create_augroup('LanguagesIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    group = indent_group,
    callback = function(ev)
        local ft = ev.match
        local applied = false

        for _, config in pairs(indent_configs) do
            if vim.tbl_contains(config.types, ft) then
                set_indent(config.size, config.expand)
                applied = true
                break
            end
        end

        if not applied then
            set_indent(4, true)
        end
    end,
})
