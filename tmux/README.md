# Tmux config

config refer to [dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/tmux)

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/blog/202405061729031.png" alt="tmux" />

keybindings refer to [tmux_cheatsheet](https://tmuxcheatsheet.com/)

|     key      |  binding   |        description        |
| :----------: | :--------: | :-----------------------: |
| `Ctrl+Space` | leader key |     set **`prefix`**      |
|   `prefix`   |     r      |       reload config       |
|   `prefix`   |     ,      |       rename window       |
|   `prefix`   |     q      |        kill window        |
|   `prefix`   |     -      |  split window vertically  |
|   `prefix`   |     =      | split window horizontally |
|    `Ctrl`    |     p      |      previous window      |
|    `Ctrl`    |     n      |        next window        |
|    `Ctrl`    |     h      |      select pane -L       |
|    `Ctrl`    |     l      |      select pane -R       |
|    `Ctrl`    |     k      |      select pane -U       |
|    `Ctrl`    |     j      |      select pane -D       |
|   `prefix`   |     c      |        new window         |



- install `tmux`

    ```bash
    brew install tmux
    
    # config
    mkdir -p ~/.config/tmux
    vim ~/.config/tmux/tmux.conf
    # all settings refer to dotfiles
    ```

- status bar

    ```bash
    # Status bar
    set-option -g status on
    set-option -g status-interval 1
    set-option -g status-justify centre
    set-option -g status-style "bg=#3e3d3d"
    
    set-option -g status-left "[#S] "
    #set-option -g status-left "#[bg=#0087ff] ❐ #S "
    set-option -g status-left-length 400
    set-option -g status-left-style default
    
    set-option -g status-right "%Y-%m-%d %H:%M "
    #set -g status-right "#[bg=red] %Y-%m-%d %H:%M "
    set-option -g status-right-length 600
    set-option -g status-right-style default
    
    set -wg window-status-current-format " #I:#W#F "
    set -wg window-status-current-style "fg=#cb231d,bg=#3e3d3d"
    #set -wg window-status-current-style "bg=red" # red
    #set -wg window-status-last-style "fg=red"
    set -wg window-status-separator ""
    ```

- install `tpm`

    - `prefix` + `I` to installs new plugins
    - `prefix` + `U` to update plugins
    - `prefix` + `alt` + `u` to uninstall/remove

    ```bash
    tmux
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

