
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
source <(fzf --zsh)

show_file_or_dir_preview="if [ -d {} ]; then tree -C {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_COMPLETION_TRIGGER='**'

export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--height=40% --tmux center --layout=reverse --border --info=inline --preview '$show_file_or_dir_preview'"
# export FZF_DEFAULT_OPTS="--height 40% --tmux center --layout=reverse --border --info=inline --preview 'fzf-preview.sh {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"

export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
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

# https://junegunn.github.io/fzf/tips/ripgrep-integration/
# ripgrep->fzf->nvim   query-> edit
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --delimiter : \
      --preview 'bat --style=numbers,changes,header --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

# zoxide 
eval "$(zoxide init zsh)"
# with fzf
z() {
  local dir=$(
    zoxide query --list --score |
    fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}


# cheat.sh
export CHEAT_DIR=$HOME/Documents/Tools/Cheat
export PATH=$PATH:$CHEAT_DIR/bin

# go path
export GO_PATH=$HOME/Documents/Code/Path_Go
export PATH=$PATH:$GO_PATH/bin

# java home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# maven home
export MAVEN_HOME=$HOME/Documents/Tools/maven/maven-3.9.9
export PATH=$MAVEN_HOME/bin:$PATH

# gradle home 
export GRADLE_HOME=$HOME/Documents/Tools/gradle/gradle-8.12
export PATH=$GRADLE_HOME/bin:$PATH
# local repo
export GRADLE_USER_HOME=$HOME/Documents/Tools/gradle/gradle-repository


# command tools
alias cat='bat'

# lsd
alias ls='lsd'
alias la='ls -la'
alias lt='ls --tree'

# git
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit -n 20"

# yazi
function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

