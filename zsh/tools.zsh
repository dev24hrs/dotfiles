# last directory
chpwd() {
 # Save the current directory to a file
 echo $PWD > ~/.last_directory
}
[ -f ~/.last_directory ] && cd $(cat ~/.last_directory)

# cheat.sh
ch() {
    curl cheat.sh/$argv[1]
}

proxy() {
    git config --global http.proxy 127.0.0.1:7890 && 
    git config --global https.proxy 127.0.0.1:7890
}

noproxy() {
    git config --global --unset http.proxy &&
    git config --global --unset https.proxy
}

showproxy() {
    git config --global --get http.proxy &&
    git config --global --get https.proxy
}

nic() {
    # local session_name="${1:-$(basename "$PWD")}"
    local session_name="code"

    # if aleady inside tmux, dont nest
    if [ -n "$TMUX" ]; then
        echo "Already in a tmux session. Deatch first or run from outside tmux."
        return 1
    fi

    # Attach if session aleady exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return
    fi

    # Create a new session (pane 1: neovim)
    tmux new-session -d -s "$session_name" -c "$PWD" -x "$(tput cols)" -y "$(tput lines)"

    # splite top pane right full-height for gemini (30% width)
    tmux split-window -h -t "$session_name":1.1 -c "$PWD" -l 30%

    # pane layout: 1=neovim (top-left) 2=gemini (top-right) 3=terminal (bottom)
    tmux send-keys -t "$session_name":1.1 "nvim" C-m
    tmux send-keys -t "$session_name":1.2 "gemini" C-m

    # focus on neovim pane
    tmux select-pane -t "$session_name":1.1

    # splite bottom for terminal (20% height )
    tmux split-window -v -t "$session_name" -c "$PWD" -l 20%

    # attach
    tmux attach-session -t "$session_name"
}
