# git
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gc 'git commit -m'
abbr -a gP 'git push'
abbr -a gp 'git pull'
abbr -a gd 'git diff'
abbr -a gco 'git checkout'
abbr -a gb 'git branch'
abbr -a gl "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20 --date=format:'%Y-%m-%d %H:%M %a'"

# tmux
abbr -a ts 'tmux source-file ~/.config/tmux/tmux.conf'
abbr -a tl 'tmux ls'
abbr -a ta 'tmux attach'
abbr -a tn 'tmux new -s'
abbr -a tk 'tmux kill-session -t'

# golang
abbr -a gmi "go mod init"
abbr -a gmt "go mod tidy"
abbr -a gmv "go mod vendor"
abbr -a gmw "go mod why"
