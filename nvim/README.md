# Neovim Config

This repo hosts my Neovim configuration.

The `init.lua` is the config entry point for terminal Neovim.

It's a simple but satisfying configuration for me, with `lua, bash, json, yaml, sql, markdown, golang, rust` yet.
Always update and keep it more usefully.

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151334838.png" alt="dashboard" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151335169.png" alt="telescope" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151337040.png" alt="outline" width="100%" />

## Feautures

```bash
~/.config/nvim
❯ tree .
├── init.lua
├── lazy-lock.json
├── lsp
│   ├── bashls.lua
│   ├── gopls.lua
│   ├── jsonls.lua
│   ├── lua_ls.lua
│   ├── pyright.lua
│   ├── rust-analyzer.lua
│   ├── sqlls.lua
│   └── yamlls.lua
├── lua
│   ├── basic
│   │   ├── autocmds.lua
│   │   ├── folding.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── core
│   │   ├── lazy.lua
│   │   └── lsp.lua
│   ├── plugins
│   │   ├── languages
│   │   │   ├── n-gopher.lua
│   │   │   └── n-rust.lua
│   │   ├── n-ai.lua
│   │   ├── n-autopairs.lua
│   │   ├── n-blink.lua
│   │   ├── n-comment.lua
│   │   ├── n-conform.lua
│   │   ├── n-dashboard.lua
│   │   ├── n-diff.lua
│   │   ├── n-fidget.lua
│   │   ├── n-flash.lua
│   │   ├── n-fzf.lua
│   │   ├── n-gitsigns.lua
│   │   ├── n-hlslens.lua
│   │   ├── n-indent.lua
│   │   ├── n-lazydev.lua
│   │   ├── n-lint.lua
│   │   ├── n-lualine.lua
│   │   ├── n-markdown.lua
│   │   ├── n-mason.lua
│   │   ├── n-noice.lua
│   │   ├── n-project.lua
│   │   ├── n-replace.lua
│   │   ├── n-theme.lua
│   │   ├── n-todo.lua
│   │   ├── n-toggleterm.lua
│   │   ├── n-tree.lua
│   │   └── n-treesitter.lua
│   └── utils
│       └── spinner.lua
└── stylua.toml
```



## Plugins

Apart from native plugins, try to choose plugins which beautiful & useful & minimized to use.

-   Plugin management : [lazy.nvim](https://github.com/folke/lazy.nvim)

-   Color scheme : [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

-   LSP completion : nvim native lsp

-   Mason plugin : [mason.nvim](https://github.com/williamboman/mason.nvim)

    ```bash
    # if cant install some lsp or formatter e.g u should set npm config set strict-ssl false
    npm config set strict-ssl false
    ```

-   Auto-completion : [blink.cmp](https://github.com/Saghen/blink.cmp)

-   Snippets : [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)  &  [luasnip](https://github.com/L3MON4D3/LuaSnip)

- File explorer : [nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua)

- ~~File explorer : [yazi](https://github.com/mikavilpas/yazi.nvim)~~

- Fuzzy finder : [fzf-lua](https://github.com/ibhagwan/fzf-lua) 

- Terminal : [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) 

- Gitsigns : [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)

- LazyGit : [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)

- Diffview : [mini.diff](https://github.com/nvim-mini/mini.diff)

- Code treesitter : [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

- Linter plugin : [nvim-lint](https://github.com/mfussenegger/nvim-lint)

- Code format : [conform.nvim](https://github.com/stevearc/conform.nvim) 

- Markdown : [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim)

- Dashboard : [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)

- Auto-pair : [nvim-autopairs](https://github.com/windwp/nvim-autopairs) 

- Comment : [Comment.nvim](https://github.com/numToStr/Comment.nvim) 

- Indent scope : [mini.indentscope](https://github.com/echasnovski/mini.indentscope)

- Statusline : [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim)

- UI plugin : 

    -   [noice.nvim](https://github.com/folke/noice.nvim)
    -   [nvim-notify](https://github.com/rcarriga/nvim-notify)
    -   [fidget.nvim](https://github.com/j-hui/fidget.nvim)  manage lsp progress messages

- Project Management : [project.nvim](https://github.com/ahmedkhalf/project.nvim)

- Hlsearch : [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) 

- Enhanced search : [flash.nvim](https://github.com/folke/flash.nvim) 

- Managing crates.io dependencies: [crates.nvim](https://github.com/Saecki/crates.nvim) 

- AI : 

    -   [Codeium](https://github.com/Exafunction/windsurf.vim) 
    -   [copilot.vim](https://github.com/github/copilot.vim)
    -   [copilot.lia](https://github.com/zbirenbaum/copilot.lua)
    -   [codecompanion.nvim](olimorris/codecompanion.nvim)

## Keymaps

default keybindings refer to [vim cheatsheet](https://vim.rtorr.com/lang/zh_cn/)

### Basic keymap

|    Key     |           Desc           |
| :--------: | :----------------------: |
|   space    |        leader key        |
|     J      | move selected line down  |
|     K      |  move selected line up   |
|     H      | move cursor to line head |
|     L      | move cursor to line end  |
|     zc     |         folding          |
|     zx     |        unfolding         |
| \<leader>w |      Format buffer       |

### Comment keymaps

|    Key     |                  Desc                  |
| :--------: | :------------------------------------: |
| \<leader>[ |    [Comment]: Comment line or lines    |
| \<leader>] |   [Comment]: UnComment line or lines   |
| \<leader>\ | [Comment]: Comment/Uncomment blockwise |

### Fzf keymaps

#### find files or words or buffers

|     Key     |                Desc                 |
| :---------: | :---------------------------------: |
| \<leader>fl |    [Fzf]: Files List in project     |
| \<leader>fw | [Fzf]: Find Word in current buffer  |
| \<leader>fg |  [Fzf]: Find Grep words in project  |
| \<leader>fr |      [Fzf]: Find Recent files       |
| \<leader>fb |    [Fzf]: Find existing Buffers     |
| \<leader>fc | [Fzf]: Find in neovim Configuration |
| \<leader>fp |      [Project]: Find Projects       |

#### lsp

|     Key     |             Desc              |
| :---------: | :---------------------------: |
|     gd      |    [Fzf]: Goto Definition     |
|     gp      | [Fzf]: Goto Peke Declarations |
|     gy      | [Fzf]: Goto TYpe Definitions  |
|     gi      |  [Fzf]: Goto Implementations  |
|     gr      |    [Fzf]: Goto References     |
|     gs      |    [Fzf]: Goto LSP Symbols    |
| \<leader>ci |     [Fzf]: Incoming Calls     |
| \<leader>co |     [Fzf]: Outgoing Calls     |
| \<leader>la |    [Fzf]: LSP Code Actions    |
| \<leader>,  |    [Lsp]: LSP Code Actions    |
| \<leader>lf |       [Fzf]: LSP Finder       |
| \<leader>r  | [Fzf]: Rename all references  |
|      K      |  [Lsp]: Hover Documentation   |

#### git

|     Key     |            Desc             |
| :---------: | :-------------------------: |
| \<leader>gf |    [Fzf]: List Git Files    |
| \<leader>gs |   [Fzf]: List Git Status    |
| \<leader>gd |    [Fzf]: List Git Diff     |
| \<leader>gl | [Fzf]: List Git Commits Log |
| \<leader>gb |  [Fzf]: List Git Branches   |

#### show  diagnostics or keymaps

|     Key     |               Desc               |
| :---------: | :------------------------------: |
| \<leader>sd |     [Fzf]: Show Diagnostics      |
| \<leader>sk |       [Fzf]: Show Keymaps        |
| \<leader>sh |  [Fzf]: Show Neovim Help Pages   |
| \<leader>sn | [Notify]: Search Notify Messages |

### Gitsigns keymaps

|     Key     |           Desc            |
| :---------: | :-----------------------: |
|     ]h      |   [Gitsigns]: Next Hunk   |
|     [h      | [Gitsigns]: Previous Hunk |
| \<leader>hp | [Gitsigns]: Preview Hunk  |
| \<leader>hb |  [Gitsigns]: Blame Hunk   |
| \<leader>hd |   [Gitsigns]: Diff This   |
| \<leader>hs |  [Gitsigns]: Stage Hunk   |
| \<leader>hr |  [Gitsigns]: Reset Hunk   |

### Todo keymaps

|     Key     |             Desc              |
| :---------: | :---------------------------: |
|     ]t      |   [Todo]: Next Todo comment   |
|     [t      | [Todo]: Previous Todo comment |
| \<leader>td |    [Todo]: Show Todo List     |

### AI

|     Key     |                 Desc                  |
| :---------: | :-----------------------------------: |
| \<leader>cl |     [CodeCompanion]: Actions List     |
| \<leader>ca |    [CodeCompanion]: Action Inline     |
| \<leader>cc |  [CodeCompanion]: CodeCompanion Chat  |
| \<leader>cp |       [CodeCompanion]: Chat Add       |
|   \<C-s>    | [CodeCompanion]: Send context in Chat |
|   \<C-c>    |      [CodeCompanion]: Close Chat      |



### Other

|     Key     |             Desc              |
| :---------: | :---------------------------: |
| \<leader>e  | [NvimTree]: Toggle Nvim Tree  |
|   \<c-/>    | [Toggleterm]: Open Toggleterm |
| \<leader>lg |    [LazyGit]: Open LazyGit    |
| \<leader>to |  [Diff]: Toggle diff overlay  |



## Requirements

- Neovim 0.11+ : for neovim native lsp config, remove `nvim-lspconfig`

- ~~[yazi](https://github.com/sxyazi/yazi)~~

- [lazygit](https://github.com/jesseduffield/lazygit)

- [ripgrep](https://github.com/BurntSushi/ripgrep)

- [jsregexp](https://github.com/kmarius/jsregexp)

- [luarocks](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-macOS)

  ```bash
  #  for luasnip
  brew install luarocks
  luarocks install jsregexp
  ```

## Recommended

Personal perfer neovim author

-   adibhanna
    -   tutoria: https://github.com/adibhanna/minimal-vim
    -   main: https://github.com/adibhanna/nvim
-   Jacky-Lzx
    -   tutoria: https://github.com/Jacky-Lzx/nvim.tutorial.config
    -   main: https://github.com/Jacky-Lzx/nvim_conf
-   patricorgi
    -   https://github.com/patricorgi/dotfiles
