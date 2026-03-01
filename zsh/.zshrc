# ========= homebrew ========
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# brew 4.0版本后的替换中科大源
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# ========= zsh plugins ========
[[ -f ~/.config/zsh/zsh_plugins.zsh ]] && source ~/.config/zsh/zsh_plugins.zsh

# ========= code env ========
[[ -f ~/.config/zsh/code_env.zsh ]] && source ~/.config/zsh/code_env.zsh

# ========= fzf ========
[[ -f ~/.config/zsh/fzf.zsh ]] && source ~/.config/zsh/fzf.zsh

# ========= zoxide ========
[[ -f ~/config/zsh/zoxide.zsh ]] && source ~/.config/zsh/zoxide.zsh

# ========= chpwd ========
[[ -f ~/.config/zsh/tools.zsh ]] && source ~/.config/zsh/tools.zsh

# ========= ai-pai ========
# [[ -f ~/.config/zsh/ai_api.zsh ]]  && source ~/.config/zsh/ai_api.zsh

# ========= alias ========
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# starship
eval "$(starship init zsh)"
# zoxide 
eval "$(zoxide init zsh)"

