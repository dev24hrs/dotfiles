return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        check_ts = true, -- 使用 Treesitter 识别代码块
        map_cr = false, -- 重要：禁用自带的回车映射，防止和 blink.cmp 冲突导致双倍缩进
    },
}
