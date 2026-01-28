# bat
alias cat='bat'

# lazygit
alias lg='lazygit'

# musicfox
alias mu='musicfox'

# lsd
alias ls='lsd'
alias la='ls -la'
alias lt='ls --tree'

# git
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20 --date=format:'%Y-%m-%d %H:%M %a'"

alias gs='git status'
alias gc='git commit -m'
alias ga='git add'

# tmux 
alias ts='tmux source-file ~/.config/tmux/tmux.conf'
alias tl='tmux ls'
alias ta='tmux attach'
alias tn='tmux new -s'
alias tk='tmux kill-session -t'
