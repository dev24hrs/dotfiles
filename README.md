---
title: " Mac Dotfiles"
author: dev24hrs
tags:
  - dotfiles
  - config
---

# [Mac] WorkFlow

<!--toc:start-->

- [[Mac] WorkFlow](#mac-workflow)
  - [Enhance terminal](#enhance-terminal)
  - [Git Config](#git-config)
  - [Homebrew](#homebrew)
  - [Fish Shell](#fish-shell)
  - [Cli Tools](#cli-tools)
    - [Starship](#starship)
    - [Bat](#bat)
    - [Fzf](#fzf)
    - [Zoxide](#zoxide)
    - [Delta](#delta)
    - [Lsd](#lsd)
    - [Fd & RipGrep](#fd-ripgrep)
    - [LazyGit](#lazygit)
    - [Cheat.sh](#cheatsh)
    - [Go-musicbox](#go-musicbox)
    - [Btop](#btop)
  - [Font](#font)
  - [System Keymap](#system-keymap)
  - [WezTerm](#wezterm)
  - [Tmux](#tmux)
  - [Neovim](#neovim)
  - [vimrc](#vimrc)
  - [Golang](#golang)
    - [Books](#books)
  - [Rust](#rust)
    - [Setup](#setup)
    - [Awesome Rust](#awesome-rust)
  - [Apps](#apps)
  - [Rime 输入法](#rime-输入法)
  <!--toc:end-->

> This is a collection of configurations that includes all on my Mac.
>
> keywords: [git, homebrew, nerdfonts, fish, starship, neovim, tmux, golang, rust]

---

## Enhance terminal

```bash
#  终端下执行以下几个命令，然后重新登出当前账户并登入（或者重启）
#  Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1  # 默认值 2，设置成 1 合适，设置成 0 就太快了
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# mac 查应用标识id
osascript -e 'id of app "app name"'
# e.g
osascript -e 'id of app "Wezterm"'

```

## Git Config

- refer to [new SSH key](https://docs.github.com/zh/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

  ```bash
  git config --global user.email "xxx@foxmail.com"
  git config --global user.name "xxx"

  # ssh-key
  brew install openssh
  ssh-keygen -t ed25519 -C "your_email@example.com"

  touch ~/.ssh/config

  # add
  Host github.com
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_ed25519

  ssh-add ~/.ssh/id_ed25519

  pbcopy < ~/.ssh/id_ed25519.pub
  # then add to your github settings->ssh key

  # set proxy
  git config --global http.proxy 127.0.0.1:7890
  git config --global https.proxy 127.0.0.1:7890

  #unset
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  # pretty git log
  # add to ~/.zshrc
  alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20 --date=format:'%Y-%m-%d %H:%M %a'"
  ```

- gitignore global

  ```bash
  echo .DS_Store >> ~/.gitignore_global
  git config --global core.excludesfile ~/.gitignore_global
  ```

## Homebrew

Use pkg to install [homebrew](https://github.com/Homebrew/brew/releases/), but need to config `~/.zshrc` or `config.fish`

```bash
# add to ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# set ustc mirrors
# export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
# export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
# export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
# then
source ~/.zshrc

brew update
# if unistall
# then brew autoremove
# brew cleanup
# brew cleanup --prune=all
```

## Fish Shell

Config refer to [fish config](https://github.com/dev24hrs/dotfiles/blob/main/fish/config.fish)
使用fish 作为默认shell. 以下可能使用到的cli 命令配置均基于fish shell.

```bash
# Homebrew安装
brew install fish
# Fish 路径写入信任列表
echo $(which fish) | sudo tee -a /etc/shells
# 切换默认 Shell
chsh -s $(which fish)
```

```bash
# add to config.fish
# brew
eval (/opt/homebrew/bin/brew shellenv)
# add this to set XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME "$HOME/.config"

source ~/.config/fish/config.fish
```

## Cli Tools

### Starship

refer to [starship config](https://github.com/dev24hrs/dotfiles/blob/main/starship.toml)

- install [starship](https://starship.rs/guide/)

```bash
brew install starship
```

- with fish

```bash
# add to config.fish
function starship_transient_prompt_func
    starship module character
end
starship init fish | source

# config
# use preset & restart terminal starship preset nerd-font-symbols -o ~/.config/starship.toml
# or can refer to github dotfiles
```

- ~~with zshrc~~

```bash
vim ~/.zshrc
eval "$(starship init zsh)"
```

### Bat

- install [bat](https://github.com/sharkdp/bat)

```bash
brew install bat
```

- config

```bash
# config
bat --generate-config-file
# add to ~/.config/bat/config
--paging=never
--theme="gruvbox-dark"
--style="numbers,changes,header,snip,rule"
```

- with fish

```bash
# add to config.fish
alias cat='bat'
```

### Fzf

- install [fzf](https://github.com/junegunn/fzf)

```bash
brew install fzf
```

- with fish

```bash
# add to config.fish
# FZF
fzf --fish | source
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# --preview-window 60% 表示预览窗口占宽度中的比例
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 'right,60%,border-left'"
set -gx FZF_CTRL_R_OPTS "--preview-window hidden"
```

### Zoxide

- install [zoxide](https://github.com/ajeetdsouza/zoxide)

```bash
brew install zoxide
```

- with fish

```bash
enable_transience
zoxide init fish | source
```

### Delta

- install [delta](https://github.com/dandavison/delta)

```bash
brew install git-delta
```

- config

```bash
# add this to ~/.gitconfig
[core]
    pager = delta
[interactive]
    diffFilter = delta --color-only
[delta]
    syntax-theme = gruvbox-dark
    # this config auto set line-numbers=true
    side-by-side = true
[merge]
    conflictstyle = diff3
# Using Delta with tmux add below to tmux.conf
# set -ga terminal-overrides ",xterm-256color:Tc"-
```

### Lsd

- install [lsd](https://github.com/lsd-rs/lsd)

```bash
brew install lsd
```

- with fish

```bash
# lsd
alias ls='lsd'
alias la='lsd -la'
alias lt='lsd --tree'
```

### Fd & RipGrep

- install [fd](https://github.com/sharkdp/fd)
- install [ripgrep](https://github.com/BurntSushi/ripgrep)

```bash
brew install fd
brew install ripgrep
```

### LazyGit

refer to [config](https://github.com/dev24hrs/dotfiles/blob/main/lazygit/config.yml) or [default config](https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md)

- install [lazygit](https://github.com/jesseduffield/lazygit)

```bash
brew install lazygit
```

- with fish

```bash
alias lg='lazygit'
```

### Cheat.sh

- install [cheat.sh](https://github.com/chubin/cheat.sh)

```bash
# add to config.fish
function ch --description 'curl cheat.sh'
    curl cheat.sh/$argv[1]
end

# use
ch go chan
```

### Go-musicbox

- install [go-musicfox](https://github.com/go-musicfox/go-musicfox)

```bash
brew install anhoder/go-musicfox/go-musicfox
```

- config

```bash
# macos default config path is : $HOME/Library/Application Support/go-musicfox/config.toml
# 软链到 ~/.config/go-musicfox
# mkdir -p ~/.config/go-musicfox
cd ~/.config/go-musicfox
# ln -s $HOME/Library/Application Support/go-musicfox go-musicfox
nvim config.toml
```

- with fish

```bash
alias mu='musicfox'
```

### Btop

- install [btop](https://github.com/aristocratos/btop)

```bash
brew install btop
```

- config

```bash
# config path is : $HOME/.config/btop/btop.conf
# themes path is : $HOME/.config/btop/themes/
# add https://github.com/aristocratos/btop/blob/main/themes/gruvbox_material_dark.theme to theme path

# use bt and the press m to option config to set theme as gruvbox_material_dark
```

- with fish

```bash
alias bt='btop'
```

## Font

perfer nerd fonts [nerd fonts](https://www.nerdfonts.com/font-downloads)

- [firacode](https://github.com/tonsky/FiraCode)

- [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono)

- [Recursive](https://www.recursive.design/) - prefer fonts

- [思源黑体](https://github.com/adobe-fonts/source-han-sans)

## System Keymap

|     keymap      |      desc      |
| :-------------: | :------------: |
| shift + cmd + L |   打开控制台   |
|  ctrl + space   |   切换输入法   |
|   cmd + space   | 打开 Spotlight |
|    ctrl + →     |  下一个space   |
|    ctrl + ←     |  上一个space   |
|   ctrl + 1-4    | 切换到1-4space |

## WezTerm

refer to [wezterm config](https://github.com/dev24hrs/dotfiles/tree/main/wezterm)

- install [wezterm](https://wezterm.org/install/macos.html#homebrew)

```bash
brew install --cask wezterm
# or
brew install --cask wezterm@nightly
```

## Tmux

config refer to [tmux dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/tmux)

> [!NOTE]

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/blog/202405061729031.png" alt="tmux" />

## Neovim

config refer to [nvim dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/nvim)

> [!NOTE]

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151334838.png" alt="dashboard" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151335169.png" alt="telescope" />

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/go/202404151337040.png" alt="outline" width="100%" />

## vimrc

config vim

```bash
" basic
" fzf"
set rtp+=/opt/homebrew/opt/fzf

if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
set t_Co=256
set termguicolors
set background=dark
set nocompatible
set number
set nowrap
set mouse=a
set clipboard=unnamed

" tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set autoindent
set backspace=eol,start,indent
set noexpandtab

" search
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set regexpengine=0

" menu
set showcmd
set showmode
set wildmenu

" other
set nobackup
set nowb
set nowritebackup
set noswapfile

set noerrorbells

set wildmenu               " enhance command-line auto-completion
set wildignore=*.o         " files matched will be ignored by wildmenu
set wildmode=longest:list  " Completion mode

" encoding
" set spell spelllang=en_us
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

filetype indent on

" auto tag
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i

let g:indentLine_enabled = 1

" move to beginning/end of line
nnoremap H ^
nnoremap L $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Gruvbox config
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
```

## Golang

- install

```bash
# brew install
brew install go
go version
brew upgrade go

# set env
mkdir -p $HOME/Documents/Tools/GoPath/pkg
mkdir -p $HOME/Documents/Tools/GoPath/bin

go env -w GOPROXY=https://goproxy.cn,direct
go env -w GO111MODULE=on
go env -w GOPATH=$HOME/Documents/Tools/GoPath

# gofumpt
go install mvdan.cc/gofumpt@latest

# gopls
go install golang.org/x/tools/gopls@latest
```

- with fish

```bash
set -gx GOPATH $HOME/Documents/Tools/GoPath
fish_add_path $GOPATH/bin
```

### Books

- Go 语言圣经 <https://golang-china.github.io/gopl-zh/index.html>
- Go 语言设计与实现 <https://draveness.me/golang/>
- Go 语言高级编程 <https://chai2010.cn/advanced-go-programming-book/index.html>

## Rust

### Setup

Refer to [set up](https://www.rust-lang.org/learn/get-started)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

其他命令：

```bash
rustc --version
cargo --version
rustup update
```

- 官方文档中文 <https://rustwiki.org/>

- Rust 程序设计语言 <https://rustwiki.org/zh-CN/book/>

- Rust 程序设计语言 <https://doc.rust-lang.org/book/ch01-01-installation.html>

- Rust Cookbook 中文版 <https://rustwiki.org/zh-CN/rust-cookbook/>

### Awesome Rust

- awesome rust <https://github.com/rust-unofficial/awesome-rust>

- Rust 嵌入式 <https://github.com/rust-embedded/awesome-embedded-rust>

## Apps

- [AlDente](https://apphousekitchen.com/) -- charge limiter app

- [lemon](https://lemon.qq.com/) -- mac clean app

- [Chrome](https://www.google.com/intl/zh-CN/chrome/) -- browser

- [appcleaner](https://freemacsoft.net/appcleaner/) -- app manager

- [snipaster](https://www.snipaste.com/) -- screenshot

- [vlc](https://www.videolan.org/vlc/) -- video player

- [easydict](https://github.com/tisfeng/Easydict/) -- translator app

- [Vimium](https://github.com/philc/vimium) -- Chrome & Arc extension for Vim

  ```bash
  # config Custom key
  unmap /
  map <c-/> enterFindMode
  # Custom search engines
  # so u can press o and enter g/bd/gh to search something
  bd: http://www.baidu.com/s?wd=%s+-csdn Baidu
  g: https://www.google.com/search?q=%s Google
  gh: https://github.com/search?q=%s GitHub
  ```

- [sublime text](https://www.sublimetext.com/) -- buy license from taobao

  ```bash
  {
   "ignored_packages":
   [
    "Vintage",
   ],
   "color_scheme": "ayu-light.sublime-color-scheme",
   "theme": "ayu-light.sublime-theme",
   "always_prompt_for_file_reload": true,
   "font_size": 16,
   "remember_open_files": true,
   "update_check": false,
   "font_face": "RecMonoCasual Nerd Font",
  }
  ```

- [PicGo](https://picgo.github.io/PicGo-Doc/zh/guide/) -- upload images to GitHub

  > if u forget your GitHub tokens, u cant find it in the blew file `data.json`

  ```json
  // the data.json saved all the uploaded imgs info
  // this is vscode settings
  "picgo.dataPath": "$home/Library/Application Support/picgo/data.json",
  ```

  If use typora & picgo app, when u pasted images in typora,it will cached images in the path`$home/Library/Application\ Support/typora-user-images`,so u need clean it.

## Rime 输入法

- 官网下载 [Rime](https://github.com/rime/squirrel). 安装完成后需要到设置->键盘->输入法 中添加鼠须管输入法
- Homebrew安装. 注销用户重新登录才能在系统设置的输入法处看到鼠须管输入法

  ```bash
  brew install --cask squirrel
  ```

- 安装[雾凇拼音](https://dvel.me/posts/rime-ice/)
  - 点击 mac右上角输入法squirrel图标,打开settings目录
  - 下载仓库内容,解压后全部复制到 settings目录
  - 再次点击squirrel图标,然后点击deploy 部署, 即可开始使用
- 配置雾凇拼音
  - 在settings目录下创建`default.custom.yaml`,添加内容

  ```yaml
   patch:
    schema_list:
     # 可以直接删除或注释不需要的方案，对应的 *.schema.yaml 方案文件也可以直接删除
     # 除了 t9，它依赖于 rime_ice，用九宫格别删 rime_ice.schema.yaml
      - schema: rime_ice               # 雾凇拼音（全拼）
      - schema: double_pinyin          # 自然码双拼
      - schema: double_pinyin_abc      # 智能 ABC 双拼
      - schema: double_pinyin_sogou    # 搜狗双拼
    # 菜单
    menu:
      page_size: 7  # 候选词个数
  # 中西文切换
  #
  # good_old_caps_lock:
  # true   切换大写
  # false  切换中英
  # macOS 偏好设置的优先级更高，如果勾选【使用大写锁定键切换“ABC”输入法】则始终会切换输入法。
  # 切换中英：
  # 不同的选项表示：打字打到一半时按下了 CapsLock、Shift、Control 后：
  # commit_code  上屏原始的编码，然后切换到英文
  # commit_text  上屏拼出的词句，然后切换到英文
  # clear        清除未上屏内容，然后切换到英文
  # inline_ascii 切换到临时英文模式，按回车上屏后回到中文状态
  # noop         屏蔽快捷键，不切换中英，但不要屏蔽 CapsLock
  ########## 关闭  macos 使用大写锁定键切换“ABC”输入法
    ascii_composer:
   good_old_caps_lock: true
   switch_key:
     Caps_Lock: commit_code
     Shift_L: commit_code
     Shift_R: noop
     Control_L: clear
     Control_R: noop
    key_binder:
      bindings:
      - { when: always, accept: Release+Escape, toggle: ascii_mode }
  ```

  - 在settings目录下创建`squirrel.custom.yaml`, 添加内容

  ```yaml
  patch:
    # options: last | default | _custom_
    # last: the last used latin keyboard layout
    # default: US (ABC) keyboard layout
    # _custom_: keyboard layout of your choice, e.g. 'com.apple.keylayout.USExtended' or simply 'USExtended'
    keyboard_layout: default
    # for veteran chord-typist
    chord_duration: 0.1 # seconds
    # options: always | never | appropriate
    show_notifications_when: appropriate

    # 以下软件默认英文模式
    # ascii_mode: false  默认输入法模式: false 中文 true 英文
    # ascii_punct: true  是否设置为英文标点
    # 使用 osascript -e 'id of app "kitty"' 命令获取对应的app 标识
    app_options:
      com.googlecode.iterm2:
        ascii_mode: true
        vim_mode: true
        ascii_punct: true
      com.jetbrains.goland:
        ascii_mode: true
        vim_mode: true
        ascii_punct: true
      com.jetbrains.intellij:
        ascii_mode: true
        vim_mode: true
        ascii_punct: true
      com.apple.Terminal:
        ascii_mode: true
        vim_mode: true
        ascii_punct: true
      com.github.wez.wezterm:
        ascii_mode: true
        vim_mode: true
        ascii_punct: true
      md.obsidian:
        ascii_mode: false
        vim_mode: true
        ascii_punct: true

    # 如果想要修改皮肤，直接更改 color_scheme 的值即可
    style:
      color_scheme: macos_dark
      color_scheme_dark: macos_dark

    preset_color_schemes:
      macos_light:
        font_face: "RecMonoCasualNF"
        font_point: 15.0
        label_font_face: "RecMonoCasualNF"
        label_font_point: 15.0
        comment_font_face: "RecMonoCasualNF"
        comment_font_point: 15.0
        candidate_list_layout: linear
        text_orientation: horizontal
        inline_preedit: true
        translucency: true
        color_space: display_p3
        corner_radius: 10.0
        hilited_corner_radius: 8.0
        border_height: -3.0
        border_width: -3.0
        line_spacing: 8.0
        base_offset: 6.0
        shadow_size: 3.0
        back_color: 0x4CDDDDDD
        candidate_text_color: 0x333333
        comment_text_color: 0x333333
        label_color: 0x5B5B5B
        hilited_candidate_back_color: 0x9A8150
        hilited_candidate_text_color: 0xFFFDFE
        hilited_comment_text_color: 0xFFFDFE
        hilited_candidate_label_color: 0xFFFFFF
        text_color: 0x333333
        hilited_text_color: 0xF7F7F7

      macos_dark:
        font_face: "RecMonoCasualNF"
        font_point: 15.0
        label_font_face: "RecMonoCasualNF"
        label_font_point: 15.0
        comment_font_face: "RecMonoCasualNF"
        comment_font_point: 15.0
        candidate_list_layout: linear
        text_orientation: horizontal
        inline_preedit: true
        translucency: true
        corner_radius: 10.0
        hilited_corner_radius: 8.0
        border_height: -3.0
        border_width: -3.0
        line_spacing: 8.0
        base_offset: 6.0
        shadow_size: 3.0
        back_color: 0x4CDDDDDD
        candidate_text_color: 0x333333
        comment_text_color: 0x333333
        label_color: 0x5B5B5B
        hilited_candidate_back_color: 0x9A8150
        hilited_candidate_text_color: 0xFFFDFE
        hilited_comment_text_color: 0xFFFDFE
        hilited_candidate_label_color: 0xFFFFFF
        text_color: 0x333333
        hilited_text_color: 0xF7F7F7
  ```

  - 配置完成后点击deploy即可使用.
