# Tmux

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/blog/202405061729031.png" alt="tmux" />

## Install tmux

```bash
brew install tmux --HEAD

# config
mkdir -p ~/.config/tmux
vim ~/.config/tmux/tmux.conf
# all settings refer to dotfiles
```

## Config tmux

config refer to [dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/tmux)

steps refer to [tmux github](https://github.com/tmux/tmux)

-   custom Status bar

```bash
# gruvbox material colorscheme (mostly)
RED="#ea6962"
GREEN="#a9b665"
YELLOW="#d8a657"
BLUE="#7daea3"
MAGENTA="#d3869b"
CYAN="#89b482"
BLACK="#1d2021"
DARK_GRAY="#32302F"
LIGHT_GRAY="#4F4946"
BG="#3e3d3d"
FG="#d4be98"

# Nerdfont characters
HALF_ROUND_OPEN="#(printf '\uE0B6')"
HALF_ROUND_CLOSE="#(printf '\uE0B4')"
TRIANGLE_OPEN="#(printf '\uE0B2')"
TRIANGLE_CLOSE="#(printf '\uE0B0')"

# Basic colors of the Statusbar
set-option -g status-style bg=${BG},fg=${FG}

# Show the window list centered between the left and the right section
set-option -g status-justify centre

# Style and set contents on the left section
set-option -g status-left "\
#[fg=${LIGHT_GRAY},bg=default]${HALF_ROUND_OPEN}\
#[bg=${LIGHT_GRAY},fg=${YELLOW}]    #S \
#[fg=${LIGHT_GRAY},bg=default]${TRIANGLE_CLOSE}\
"

# Style and set contents on the right section
set-option -g status-right "\
#[fg=${LIGHT_GRAY},bg=default]${TRIANGLE_OPEN}\
#[bg=${LIGHT_GRAY},fg=${RED}]  %Y-%m-%d %H:%M \
#[fg=${LIGHT_GRAY},bg=default]${HALF_ROUND_CLOSE}\
"

# Style and set content for the inactive windows
set-option -g window-status-format "\
 \
#I\
#[fg=${MAGENTA}]:\
#[fg=default]#W\
 \
"

# Style and set content for the active windows
set-option -g window-status-current-format "\
#[fg=${LIGHT_GRAY},bg=default]${HALF_ROUND_OPEN}\
#[bg=${LIGHT_GRAY},fg=default]#I\
#[fg=${RED}]:\
#[fg=default]#W\
#[fg=${LIGHT_GRAY},bg=default]${HALF_ROUND_CLOSE}\
"

# Set max length of left and right section
set-option -g status-left-length 100
set-option -g status-right-length 100

# Remove the separator between window list items, as we already have spacing
set-option -g window-status-separator ""
```

-   install `tpm`
    -   `prefix` + `I` to installs new plugins
    -   `prefix` + `U` to update plugins
    -   `prefix` + `alt` + `u` to uninstall/remove

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



## Use tmux

tmux中 每个session可以有多个window; 每个window 可以有多个pane;

default keybindings refer to [tmux_cheatsheet](https://tmuxcheatsheet.com/)

**Steps**

1.   使用`tmux new -s  <name>` 新建session,当前只有1个window
2.   使用`prefix + ,` 重命名当前window为`project-A`,开始代码
3.   使用中发现需要多个`window` 即 `project` 切换, 可以使用`prefix + c`创建新window
4.   使用`prefix + p` or  `prefix + n` or `prefix + 0-9` 切换不同的window
5.   在单个window中,可能需要多个pane做不同操作,根据需要使用`prefix + -`  `prefix + =`把当前window切换成横向竖向布局`pane`
6.   使用`ctrl + h j k l` 在不同的pane间切换
7.   使用`prefix + x`关闭当前的pane
8.   使用`prefix + w` 列出所有window,使用`prefix + 0-9` 切换到目标window,使用`prefix + q` 关闭不需要的当前window
9.   使用`prefix + d` 暂离session
10.   使用`tmux a -t  <name>` 重连session 或 使用`tmux kill-session -t <name>` 结束session

###  Session Keymaps

| cmd                         | desc              |
| :-------------------------- | :---------------- |
| tmux new -s  <name>         | new session       |
| tmux ls                     | show all session  |
| tmux detach                 | detach session    |
| tmux a -t  <name>           | reconnect session |
| tmux kill-session -t <name> | kill session      |

|   key    | key  |       desc        |
| :------: | :--: | :---------------: |
| Ctrl + b |  s   | show all sessions |
| Ctrl + b |  $   |  rename session   |
| Ctrl + b |  d   |  detach session   |
|   Ctrl   |  d   |   kill session    |

###  Window Keymaps

|   key    |  key  |           desc            |
| :------: | :---: | :-----------------------: |
| Ctrl + b |   w   |     show all windows      |
| Ctrl + b |   ,   |   rename current window   |
| Ctrl + b |   c   |       new a window        |
| Ctrl + b |   q   |   close  current window   |
| Ctrl + b |   -   |  split window vertically  |
| Ctrl + b |   =   | split window horizontally |
| Ctrl + b |   p   |      previous window      |
| Ctrl + b |   n   |        next window        |
|  Shift   | Left  |      previous window      |
|  Shift   | Right |        next window        |
|  Ctrl+b  |  0-9  |     switch to window      |

### Pane Keymaps

|  key   |  key  |     description     |
| :----: | :---: | :-----------------: |
| prefix |   h   |   select pane -L    |
| prefix |   l   |   select pane -R    |
| prefix |   k   |   select pane -U    |
| prefix |   j   |   select pane -D    |
| prefix |   x   | close current pane  |
| prefix | space | toggle pane layouts |

