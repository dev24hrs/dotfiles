# --- 代理管理系列 ---
function proxy
    git config --global http.proxy 127.0.0.1:12334
    git config --global https.proxy 127.0.0.1:12334
    # set -gx http_proxy http://127.0.0.1:7890
    # set -gx https_proxy http://127.0.0.1:7890
    echo (set_color green)"🌐 代理已开启 (Git & Session)"(set_color normal)
end

function noproxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    # set -e http_proxy
    # set -e https_proxy
    echo (set_color red)"🚫 代理已关闭"(set_color normal)
end

function showproxy
    echo (set_color blue)"--- Git Proxy ---"(set_color normal)
    git config --global --get http.proxy
    git config --global --get https.proxy
    # echo (set_color blue)"--- Session Proxy ---"(set_color normal)
    # echo "http_proxy:  $http_proxy"
    # echo "https_proxy: $https_proxy"
end

# --- 开发工具系列 ---
function nh --description nohup
    nohup $argv &>/dev/null &
end

function ch --description 'curl cheat.sh'
    curl cheat.sh/$argv[1]
end

function rfv --description 'use fzf with neovim'
    set -l RELOAD 'reload:rg --column --color=always --smart-case {q} || :'
    set -l OPENER 'if [ (count $FZF_SELECT_COUNT) -eq 0 ]; nvim {1} +{2}; else; nvim +cw -q {+f}; end'
    fzf --disabled --ansi --multi \
        --bind "start:$RELOAD" --bind "change:$RELOAD" \
        --bind "enter:become:$OPENER" \
        --delimiter : \
        --preview 'bat --style=numbers,changes,header --color=always --highlight-line {2} {1}' \
        --preview-window '~4,+{2}+4/3,<80(up)' \
        --query "$argv"
end

function nic --description 'new tmux session for code'
    set -l session_name code

    if set -q TMUX
        echo "Already in a tmux session."
        return 1
    end
    if tmux has-session -t $session_name 2>/dev/null
        tmux attach-session -t $session_name
        return
    end

    tmux new-session -d -s $session_name -c $PWD -x (tput cols) -y (tput lines)
    tmux split-window -h -t $session_name -c $PWD -l 35%
    tmux send-keys -t $session_name:1.2 claude C-m
    tmux select-pane -t $session_name:1.1
    tmux split-window -v -t $session_name:1.1 -c $PWD -l 25%
    tmux send-keys -t $session_name:1.1 nvim C-m
    tmux select-pane -t $session_name:1.1
    tmux attach-session -t $session_name
end

# 清理 当前目录下的 .DS_Store 文件
function dsclean --description 'Clean all .DS_Store files in current directory'
    find . -name ".DS_Store" -depth -delete
    echo (set_color green)"✨ .DS_Store files have been purged!"(set_color normal)
end

# --- dotfiles 管理系列 ---
function dots --description 'Manage dotfiles backup and restore'
    switch $argv[1]
        case backup
            # 直接在备份前执行清理：查找并删除当前目录及子目录下的 .DS_Store 文件
            echo (set_color cyan)"🧹 正在清理 .DS_Store 文件..."(set_color normal)
            find . -name ".DS_Store" -depth -delete

            # 执行备份脚本
            bash $HOME/.config/dots_backup.sh
        case restore
            # 增加一个二次确认，防止误删本地文件
            echo (set_color red)"警告: restore 将执行全量同步，本地多余配置将被删除！"(set_color normal)
            read -l -p "echo '确定继续吗? (y/N): '" confirm
            if test "$confirm" = y -o "$confirm" = Y
                # chmod +x $HOME/.config/dots_restore.sh
                bash $HOME/.config/dots_restore.sh
            else
                echo "已取消恢复。"
            end
        case '*'
            echo "用法: dots [backup|restore]"
    end
end
