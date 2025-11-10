# Snippets

Snippets collection rewrited from different languages forked from [Friendly Snippet](https://github.com/rafamadriz/friendly-snippets).
cuz friendly-snippets have too many snippets that i dont need.

## Use with blink.cmp

1. blink.cmp only need luasnip, no need friendly-snippets. and use luasnip load u snippets path, e.g ~/.config/nvim/snippets/

   ```lua
    {
    'saghen/blink.cmp',
    event = { 'BufReadPost', 'BufNewFile', 'InsertEnter' },
    version = '1._',
    dependencies = {
    -- 'rafamadriz/friendly-snippets',
        'Exafunction/windsurf.nvim',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2._',
            build = 'make install_jsregexp',
            init = function()
            -- load my snippets
                require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets' })
            end,
        },
    },
   }
   ```

2. add package.json to snippets path and config it. refer to [luasnip doc](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua)
3. config vscode snippets file named `xxx.json`.
