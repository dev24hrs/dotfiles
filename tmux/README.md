# Tmux config

config refer to [dotfiles](https://github.com/dev24hrs/dotfiles/tree/main/tmux)

<img src="https://cdn.jsdelivr.net/gh/dev24hrs/blog-img/blog/202405061729031.png" alt="tmux" />

keybindings refer to [tmux_cheatsheet](https://tmuxcheatsheet.com/)

|   key    |  binding   |        description        |
| :------: | :--------: | :-----------------------: |
| `Ctrl+b` | leader key |     set **`prefix`**      |
| `prefix` |     r      |       reload config       |
| `prefix` |     ,      |       rename window       |
| `prefix` |     q      |        kill window        |
| `prefix` |     -      |  split window vertically  |
| `prefix` |     =      | split window horizontally |
|  `Ctrl`  |     p      |      previous window      |
|  `Ctrl`  |     n      |        next window        |
|  `Ctrl`  |     h      |      select pane -L       |
|  `Ctrl`  |     l      |      select pane -R       |
|  `Ctrl`  |     k      |      select pane -U       |
|  `Ctrl`  |     j      |      select pane -D       |
| `prefix` |     c      |        new window         |



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

