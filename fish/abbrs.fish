# git
# gs gb gl rewrite by git.fish
# abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gcm 'git commit -m'
abbr -a gca 'git commit --amend'

abbr -a gco 'git checkout'
abbr -a gsw 'git switch'
abbr -a gsc 'git switch -c'

abbr -a gd 'git diff'
abbr -a gf 'git fetch'
abbr -a gl 'git pull'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease' # 比 --force 更安全

abbr -a gst 'git stash'
abbr -a gsp 'git stash pop'
abbr -a gsl 'git stash list'

abbr -a gr 'git rebase'
abbr -a gra 'git rebase --abort'
abbr -a grc 'git rebase --continue'
abbr -a gri 'git rebase -i'
abbr -a grh 'git reset --hard'
abbr -a grs 'git reset --soft'

# abbr -a gl "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20 --date=format:'%Y-%m-%d %H:%M %a'"

# tmux
abbr -a ts 'tmux source-file ~/.config/tmux/tmux.conf'
abbr -a tl 'tmux ls'
abbr -a ta 'tmux attach'
abbr -a tn 'tmux new -s'
abbr -a tk 'tmux kill-session -t'

# golang
abbr -a gmi "go mod init"
abbr -a gmt "go mod tidy"
abbr -a gmc "go clean -modcache"
abbr -a gmv "go mod vendor"
abbr -a gmw "go mod why"
