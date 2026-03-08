return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')

        npairs.setup({
            check_ts = true, -- 结合 Treesitter
        })

        -- 添加针对 {} 的回车扩展规则
        npairs.add_rules({
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
                end)
                :with_move(cond.none())
                :with_cr(cond.none())
                :with_del(cond.not_after_text(' ')),
            Rule('{}', ''):with_pair(cond.none()):with_move(cond.none()):with_cr(function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                if pair == '{}' then
                    return true
                end
            end),
        })
    end,
}
