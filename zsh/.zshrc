# ========= homebrew ========
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# brew 4.0版本后的替换中科大源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# ========= zsh plugins ========
[[ -f ~/.zsh/zsh-plugins.zsh ]] && source ~/.zsh/zsh-plugins.zsh

# ========= fzf ========
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh

# ========= zoxide ========
[[ -f ~/.zsh/zoxide.zsh ]] && source ~/.zsh/zoxide.zsh

# ========= chpwd ========
[[ -f ~/.zsh/tools.zsh ]] && source ~/.zsh/tools.zsh

# ========= code-env ========
[[ -f ~/.zsh/code-env.zsh ]] && source ~/.zsh/code-env.zsh

# ========= ai-pai ========
[[ -f ~/.zsh/ai-api.zsh ]]  && source ~/.zsh/ai-api.zsh

# ========= alias ========
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh

# starship
eval "$(starship init zsh)"

