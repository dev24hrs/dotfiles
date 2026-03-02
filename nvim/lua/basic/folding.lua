-- 基础设置
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = false
vim.o.foldmethod = 'expr'
-- 优化 fillchars 渲染
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- 优化后的虚拟文本处理函数
local function get_custom_foldtext(lnum)
    local line = vim.fn.getline(lnum):gsub('\t', string.rep(' ', vim.bo.tabstop))
    -- 简单的截断，防止单行过长影响性能
    if #line > 120 then
        line = line:sub(1, 120) .. '...'
    end

    local result = {}
    table.insert(result, { line, 'Normal' })

    local nline = vim.v.foldend - vim.v.foldstart
    table.insert(result, { '      ...... 󰁂  ' .. nline .. ' lines folded', 'Character' }) -- 使用更明显的 Hlgroups

    return result
end

-- 全局折叠函数
_G.custom_foldtext = function()
    return get_custom_foldtext(vim.v.foldstart)
end

-- 应用配置
vim.o.foldtext = 'v:lua.custom_foldtext()'
