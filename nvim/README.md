## Neovim Config

### Itroduction

This repo hosts my Nvim configuration for macOS, `init.lua` is the config entry point for terminal Neovim.  
It's a simple but satisfying configuration for me, with `lua bash json yaml sql markdown golang rust` yet.  
Always update and keep it more usefully.

<img src="https://cdn.jsdelivr.net/gh/asang24/blog-img/go/202404151334838.png" alt="dashboard" />

<img src="https://cdn.jsdelivr.net/gh/asang24/blog-img/go/202404151335169.png" alt="telescope" />

<img src="https://cdn.jsdelivr.net/gh/asang24/blog-img/go/202404151337040.png" alt="outline" />



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
│   ├── core
│   │   ├── basic.lua
│   │   ├── keymap.lua
│   │   └── lazy.lua
│   └── plugins
│       ├── languages
│       │   ├── n-golang.lua
│       │   ├── n-neotest.lua
│       │   └── n-rust.lua
│       ├── lspconfig
│       │   ├── n-cmp.lua
│       │   ├── n-fidget.lua
│       │   ├── n-lspconfig.lua
│       │   └── n-mason.lua
│       ├── n-autopairs.lua
│       ├── n-codeium.lua
│       ├── n-colorizer.lua
│       ├── n-comment.lua
│       ├── n-conform.lua
│       ├── n-dashboard.lua
│       ├── n-diffview.lua
│       ├── n-flash.lua
│       ├── n-gitsigns.lua
│       ├── n-hlslens.lua
│       ├── n-indent.lua
│       ├── n-lint.lua
│       ├── n-lualine.lua
│       ├── n-markdown.lua
│       ├── n-noice.lua
│       ├── n-project.lua
│       ├── n-replace.lua
│       ├── n-telescope.lua
│       ├── n-theme.lua
│       ├── n-toggleterm.lua
│       ├── n-tree.lua
│       └── n-treesitter.lua
└── stylua.toml
```

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin management
- [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) - Color scheme
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP and completion 
- [mason.nvim](https://github.com/williamboman/mason.nvim) - Mason plugin 

    ```bash
    # if cant install some lsp or formatter e.g u should set npm config set strict-ssl false
    npm config set strict-ssl false
    ```

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Auto-completion 
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippets
- [luasnip](https://github.com/L3MON4D3/LuaSnip) - Snippets
- [nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua) - File explorer
- [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Terminal
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Code highlighting
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - Markdown
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) - Dashboard
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Code format
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Auto-pair
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Comment
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Diffview
- [mini indentscope](https://github.com/echasnovski/mini.indentscope) - Indent scope
- ~~[Navigator.nvim](https://github.com/numToStr/Navigator.nvim) - Navigator~~
- ~~[scrollbar](https://github.com/petertriho/nvim-scrollbar) - Scroball~~
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - Linter plugin
- [noice.nvim](https://github.com/folke/noice.nvim) - UI plugin for `messages`, `cmdline` and the `popupmenu`
- [cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim) - `Project Management` plugins
- [search-replace.nvim](https://github.com/roobert/search-replace.nvim) - search and replace
- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) - Hlsearch
- [flash](https://github.com/folke/flash.nvim) - enhanced search
- [go.nvim](https://github.com/ray-x/go.nvim) - Go plugin
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) - Supercharge your Rust experience
- [crates.nvim](https://github.com/Saecki/crates.nvim) - managing crates.io dependencies
- [Codeium](https://github.com/Exafunction/codeium.vim) - Codeium autocompletes

### Requirements

- Neovim 0.9+
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [jsregexp](https://github.com/kmarius/jsregexp)

- [luarocks](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-macOS)

    ```bash
    #  for luasnip
    brew install luarocks
    luarocks install jsregexp
    ```

- [nerdfonts](https://www.nerdfonts.com/font-downloads) prefer FiraCodeNerdFont-Retina & JetBrainsMonoNerdFont-Regulare

### Optional

iterm2 config

Also can find in [my github](https://github.com/asang24/dotfiles)

- [iterm2](https://iterm2.com/) - install iterm2
- [color schemes](https://github.com/mbadolato/iTerm2-Color-Schemes) - install color schemes
- install font
  - [firacode](https://github.com/tonsky/FiraCode)
  - [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono)
  - [Recursive](https://www.recursive.design/) - prefer fonts
    - nerd font type can be installed from [nerdfonts](https://www.nerdfonts.com/font-downloads)
- import json file
  - [iterm2.json](https://github.com/asang24/dotfiles/blob/main/iterm2/iterm2.json)
  - personal theme [gruvbox-material-iterm2](https://github.com/AmmarCodes/gruvbox-material-iterm2)
- other useful settings

  - Appearance -> General -> Theme:Minimal & Tab bar:Bottom & Status bar:Top
  - Profiles

    - General -> Basic Colors:background:3e3d3d(rgb hex)
    - Text -> Font: RecMonoCasual Nerd Font 16
    - Window -> Transparency:2 & Backgroud Image:backgroud.jpeg & Blending:5
    - Keys -> set Report modifiers using CSI u -> not remove
  
  - Advanced
  
      - set `Scroll wheel sends arrow keys when in alternate screen mode` to **Yes**
  
          >   no more scrolling up or down the entire screen, only in nvim/vim mode.
