
# homebrew 
eval "$(/opt/homebrew/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"

# zsh plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# by default zsh is case sensitive
# Ignore Case Sensitive
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# fzf
eval "$(fzf --zsh)"
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ];then tree -C {} | head -200;else bat -n --color=always {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"

# use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
# fzf-git
source ~/.zsh/fzf-git.sh/fzf-git.sh


# cheat.sh
export CHEAT_DIR=$HOME/Documents/Tools/Cheat
export PATH=$PATH:$CHEAT_DIR/bin

# go path
export GO_PATH=$HOME/Documents/Code/Path_Go
export PATH=$PATH:$GO_PATH/bin

# last directory
chpwd() {
	# Save the current directory to a file
	echo $PWD > ~/.last_directory
}
[ -f ~/.last_directory ] && cd $(cat ~/.last_directory)

# command tools
alias cat='bat'

# tmux 

# lsd
alias ls='lsd'
alias la='ls -la'
alias lt='ls --tree'

# git
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20"
