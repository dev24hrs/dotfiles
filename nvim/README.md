# Neovim Config

This repo hosts my Neovim configuration.

The `init.lua` is the config entry point for terminal Neovim.

It's a simple but satisfying configuration for me, with `lua, bash, json, yaml, sql, markdown, golang, rust` yet.
Always update and keep it more usefully.

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151334838.png" alt="dashboard" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151335169.png" alt="telescope" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151337040.png" alt="outline" width="100%" />

### Feautures

```bash
~/.config/nvim
❯ tree .
.
├── README.md
├── cd-project.nvim.json
├── init.lua
├── lazy-lock.json
├── lua
│   ├── core
│   │   ├── basic.lua
│   │   ├── keymap.lua
│   │   └── lazy.lua
│   └── plugins
│       ├── languages
│       │   ├── n-neotest.lua
│       │   └── n-rust.lua
│       ├── lspconfig
│       │   ├── n-cmp.lua
│       │   ├── n-fidget.lua
│       │   ├── n-lspconfig.lua
│       │   ├── n-lspsaga.lua
│       │   └── n-mason.lua
│       ├── n-autopairs.lua
│       ├── n-codeium.lua
│       ├── n-colorizer.lua
│       ├── n-comment.lua
│       ├── n-conform.lua
│       ├── n-dashboard.lua
│       ├── n-diffview.lua
│       ├── n-flash.lua
│       ├── n-gitsigns.lua
│       ├── n-hlslens.lua
│       ├── n-indent.lua
│       ├── n-lint.lua
│       ├── n-lualine.lua
│       ├── n-markdown.lua
│       ├── n-noice.lua
│       ├── n-project.lua
│       ├── n-replace.lua
│       ├── n-telescope.lua
│       ├── n-theme.lua
│       ├── n-toggleterm.lua
│       ├── n-tree.lua.bak
│       ├── n-yazi.lua
│       └── n-treesitter.lua
└── stylua.toml
```



-   Plugin management : [lazy.nvim](https://github.com/folke/lazy.nvim)

-   Color scheme : [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

-   LSP completion : [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) 

-   Mason plugin : [mason.nvim](https://github.com/williamboman/mason.nvim)

    ```bash
    # if cant install some lsp or formatter e.g u should set npm config set strict-ssl false
    npm config set strict-ssl false
    ```

-   Auto-completion : [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

-   Snippets : [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) 

- Snippets : [luasnip](https://github.com/L3MON4D3/LuaSnip)
- ~~File explorer : [nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua)~~
- File explorer : [yazi](https://github.com/mikavilpas/yazi.nvim)
- Statusline : [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim)
- Fuzzy finder : [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) 
- Terminal : [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) 
- Gitsigns : [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)  
- Code treesitter : [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Markdown : [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) 
- Dashboard : [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) 
- Code format : [conform.nvim](https://github.com/stevearc/conform.nvim) 
- Auto-pair : [nvim-autopairs](https://github.com/windwp/nvim-autopairs) 
- Comment : [Comment.nvim](https://github.com/numToStr/Comment.nvim) 
- Diffview : [diffview.nvim](https://github.com/sindrets/diffview.nvim) 
- Indent scope : [mini indentscope](https://github.com/echasnovski/mini.indentscope) 
- Linter plugin : [nvim-lint](https://github.com/mfussenegger/nvim-lint) 
- UI plugin : [noice.nvim](https://github.com/folke/noice.nvim)
- Project Management : [cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim) 
- Search and replace : [search-replace.nvim](https://github.com/roobert/search-replace.nvim) 
- Hlsearch : [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) 
- Enhanced search : [flash](https://github.com/folke/flash.nvim) 
- Managing crates.io dependencies: [crates.nvim](https://github.com/Saecki/crates.nvim) 
- Codeium autocompletes : [Codeium](https://github.com/Exafunction/codeium.vim) 

### Requirements

- Neovim 0.10+

- [ripgrep](https://github.com/BurntSushi/ripgrep)

- [jsregexp](https://github.com/kmarius/jsregexp)

- [luarocks](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-macOS)

  ```bash
  #  for luasnip
  brew install luarocks
  luarocks install jsregexp
  ```

### Recommended

kitty config refer to [kitty config](https://github.com/mikavilpas/yazi.nvim)

Iterm2 config refer to [iterm2 dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/iterm2)
