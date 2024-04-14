## Neovim Config

### Itroduction

This repo hosts my Nvim configuration for macOS, `init.lua` is the config entry point for terminal Neovim.  
It's a simple but satisfying configuration for me, with `lua bash json yaml sql markdown golang` yet.  
Always update and keep it more usefully.

<img src="https://github.com/asang24/nvim/blob/main/demo.png" alt="demo" style="zoom:30%;" />
<img src="https://github.com/asang24/nvim/blob/main/go.png" alt="go" style="zoom:30%;" />

### Feautures

- Plugin management [lazy.nvim](https://github.com/folke/lazy.nvim)
- Color scheme [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
- LSP and completion [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- Mason plugin [mason.nvim](https://github.com/williamboman/mason.nvim)

```bash
    # if cant install some lsp or formatter e.g u should set npm config set strict-ssl false
    npm config set strict-ssl false
```

- Code,snippet,auto-completion [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Snippets [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- File explorer [nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua)
- Beautiful statusline [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim)
- Fuzzy finder [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- Terminal [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- Git integration [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- Translation [vim-translator](https://github.com/voldikss/vim-translator)
- Code highlighting [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- Markdown preview [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- Dashboard [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- Code format [conform.nvim](https://github.com/stevearc/conform.nvim)
- Auto-pair [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- Comment [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Diffview [diffview.nvim](https://github.com/sindrets/diffview.nvim)
- Indent scope [indentscope](https://github.com/echasnovski/mini.indentscope)
- Navigator [Navigator.nvim](https://github.com/numToStr/Navigator.nvim)
- Scroball [scrollbar](https://github.com/petertriho/nvim-scrollbar)
- Go plugin [go.nvim](https://github.com/ray-x/go.nvim)

### Requirements

- iterm2
  - [gruvbox-material](https://github.com/AmmarCodes/gruvbox-material-iterm2) or [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes)
  - import [json file](https://github.com/asang24/Iterm2-config/blob/main/iterm2.json)
  - [background img](https://github.com/asang24/Iterm2-config/blob/main/backgroud.jpeg)
- Neovim 0.9+
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [nerdfonts](https://www.nerdfonts.com/font-downloads) prefer FiraCodeNerdFont-Retina & JetBrainsMonoNerdFont-Regulare
