## dotfiles

### Userful Tools

#### refer to [modern-unix](https://github.com/ibraheemdev/modern-unix)

##### [Vimium](https://github.com/philc/vimium) -- Chrome & Arc extension for Vim

```bash
    # config Custom key
    unmap /
    map <c-/> enterFindMode
    # Custom search engines
    bd: http://www.baidu.com/s?wd=%s+-csdn Baidu
    g: https://www.google.com/search?q=%s Google
    gh: https://github.com/search?q=%s GitHub
```

##### [bat](https://github.com/sharkdp/bat) -- like cat but with syntax highlighting and Git integration.

```bash
    # Install
    brew install bat
    # config
    bat --generate-config-file
    # add blew to config file
    # Set the theme
    --theme="gruvbox-dark"
    --style="numbers,changes,header,snip,rule"
```

##### [delta](https://github.com/dandavison/delta) -- A viewer for git and diff output.

```bash
    # Install
    brew install git-delta
    # config
    # add this to ~/.gitconfig
    [core]
        pager = delta
    [interactive]
        diffFilter = delta --color-only
    [delta]
        syntax-theme = gruvbox-dark
        side-by-side = true     # this config auto set line-numbers=true
    [merge]
        conflictstyle = diff3
    # Using Delta with tmux add to tmux.conf
    # set -ga terminal-overrides ",xterm-256color:Tc"

```

##### [cheat.sh](https://github.com/chubin/cheat.sh) -- A CLI tool for generating cheatsheets.

```bash
    # Install
    mkdir -p $HOME/Documents/Code/Tools/Cheat
    curl https://cht.sh/:cht.sh > "$HOME/Documents/Code/Tools/Cheat/cht.sh"
    chmod +x "$HOME/Documents/Code/Tools/Cheat/cht.sh"
    # config /.zshrc
    export CHEAT_DIR=$HOME/Documents/Code/Tools/Cheat/
    export PATH=$PATH:$CHEAT_DIR/bin
    # use like
    cht.sh go chan
```

##### [joshuto](https://github.com/kamiyaa/joshuto) -- a terminal-based file manager by rust

```bash
    # install
    brew install joshuto
    # config  copy these files(joshuto/config/*) to ~/.config/joshuto/
        joshuto.toml: basic/general configuration   -- custom myself
        keymap.toml: keymapping configurations      -- custom myself
        mimetype.toml: mimetype configurations
        theme.toml: theming configurations
        icons.toml: icons customization            -- changed sh icons to 
        # make sure it's marked as executable by chmod +x preview_file.sh
        preview_file.sh: preview file
    # updated config refer to my github

```

##### [ranger](https://github.com/ranger/ranger) -- slow and often crashes; use joshuto instead

```bash
    # Install
    brew install ranger
    # config
    ranger --copy-config=all
        # commands.py             # 与以下命令一起启动的命令 :
        # commands_full.py        # 全套命令
        # rc.conf                 # 配置和绑定
        # rifle.conf              # 文件关联（用于打开文件的程序）
        # scope.sh                # 负责各种文件预览
    # vim rc.conf
    set preview_images true     # 预览图片
    set preview_images_method iterm2 # 预览图片
    set line_numbers  absolute     # 显示行号
    set show_hidden true    # 显示隐藏文件
    set draw_borders both   # 绘制边框
    # set devicons
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    # add default_linemode devicons to rc.conf
    default_linemode devicons
    # set ranger editor to nvim
    vim rifle.conf
    #set ${VISUAL:-$EDITOR} to ${VISUAL:-nvim}
```

##### [lazygit](https://github.com/jesseduffield/lazygit) -- Simple terminal UI for git commands

refer to [Keybindings_zh](https://github.com/jesseduffield/lazygit/blob/master/docs/keybindings/Keybindings_zh-CN.md)

```bash
    # Install
    brew install lazygit
    # use default config

```

##### [tmux](https://github.com/tmux/tmux) -- a terminal multiplexer

Full screenshot
<img src="https://github.com/asang24/dotfiles/blob/main/tmux-powerline/Screenshot.png" alt="screenshot" style="zoom:100%;" />

Custom keybindings

other keybindings refer to [tmux_cheatsheet](https://tmuxcheatsheet.com/)

|     key      | binding |        description        |
| :----------: | :-----: | :-----------------------: |
| `Ctrl+Space` |         |     set **`prefix`**      |
|   `prefix`   |    r    |       reload config       |
|   `prefix`   |    ,    |       rename window       |
|   `prefix`   |    q    |        kill window        |
|   `prefix`   |    j    |  split window vertically  |
|   `prefix`   |    k    | split window horizontally |
|   `Shift`    |  Left   |      previous window      |
|   `Shift`    |  Right  |        next window        |
|   `Option`   |  Left   |      select pane -L       |
|   `Option`   |  Right  |      select pane -R       |
|   `Option`   |   Up    |      select pane -U       |
|   `Option`   |  Down   |      select pane -D       |
|   `prefix`   |    H    |     resize pane -L 5      |
|   `prefix`   |    J    |     resize-pane -D 5      |
|   `prefix`   |    K    |     resize-pane -U 5      |
|   `prefix`   |    L    |     resize-pane -R 5      |
|   `prefix`   |    m    |    zoom & unzoom panes    |

- install `tmux`

```bash
    # Install
    brew install tmux
    # config
    mkdir -p ~/.config/tmux
    touch ~/.config/tmux/tmux.conf
    # nvim 中使用了c-/ 作为启动toggleterm的快捷键 & c-, c-; 作为启动codeium的快捷键
    # 如果不做以下配置将无法使用
        # set 'report modifiers using CSI u' in Iterm2
        # add to tmux.conf
        set -s extended-keys on
        set -as terminal-features 'xterm*:extkeys'
```

- install `tpm`
  - `prefix` + `I` to installs new plugins
  - `prefix` + `U` to update plugins
  - `prefix` + `alt` + `u` to uninstall/remove

```bash
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    # at the bottom of ~/.config/tmux/tmux.conf
        # List of plugins
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
        run '~/.tmux/plugins/tpm/tpm'
    # type this in terminal if tmux is already running
    tmux source ~/.config/tmux/tmux.conf
```

- install `tmux-powerline`

```bash
    # add to ~/.config/tmux/tmux.confg under tpm
     set -g @plugin 'erikw/tmux-powerline'
    tmux source ~/.config/tmux/tmux.conf

```

- config file

```bash
    ~/.config/tmux/plugins/tmux-powerline/generate_rc.sh
    mv ~/.config/tmux-powerline/config.sh.default ~/.config/tmux-powerline/config.sh
    vim ~/.config/tmux-powerline/config.sh
    # update the config.sh by setting
    TMUX_POWERLINE_SEG_DATE_FORMAT="%m/%d/%Y"
```

- config theme

```bash
    mkdir -p ~/.config/tmux-powerline/themes
    cp ~/.config/tmux/plugins/tmux-powerline/themes/default.sh ~/.config/tmux-powerline/themes/theme.sh
    vim ~/.config/tmux-powerline/themes/theme.sh
    # update the config.sh by setting
    TMUX_POWERLINE_THEME=theme
    # update theme.sh
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info 148 234" \
		#"hostname 33 0" \
		"vcs_branch 9 255" \
		#"vcs_compare 60 255" \
		#"vcs_staged 64 255" \
		"vcs_modified 9 255" \
		#"vcs_others 245 0" \
	)
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"pwd 89 211" \
		#"battery 137 127" \
		"date_day 235 136" \
		"time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}" \
		"date 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}" \
		#"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
    tmux source ~/.config/tmux/tmux.conf
```
