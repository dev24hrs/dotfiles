set -g fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR nvim

# 1. 初始化外部工具
eval (/opt/homebrew/bin/brew shellenv)

set -gx XDG_CONFIG_HOME "$HOME/.config"

# 2. 导出开发环境变量 (使用 set -gx)
set -gx GOPATH $HOME/Documents/Tools/GoPath
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
set -gx MAVEN_HOME $HOME/Documents/Tools/maven/maven-3.9.9
set -gx GRADLE_HOME $HOME/Documents/Tools/gradle/gradle-8.12
set -gx GRADLE_USER_HOME $HOME/Documents/Tools/gradle/gradle-repository

# 3. 路径管理
# go install 的路径
fish_add_path $GOPATH/bin
# Go 语言编译器目录
# /opt/homebrew/opt/go 是 Homebrew 指向当前 Go 版本的软链
# 多个 Go 版本时指定某一个版本路径
fish_add_path /opt/homebrew/opt/go/bin
fish_add_path $JAVA_HOME/bin
fish_add_path $MAVEN_HOME/bin
fish_add_path $GRADLE_HOME/bin

# 4. 别名 (Alias)
alias lg='lazygit'
alias mu='musicfox'
alias bt='btop'
# lsd
alias ls='lsd'
alias la='lsd -la -A -X'
alias lt='lsd --tree'
# tmux
alias ts='tmux source-file ~/.config/tmux/tmux.conf'
alias tl='tmux ls'
alias ta='tmux attach'
alias tn='tmux new -s'
alias tk='tmux kill-session -t'

# 5. FZF 默认选项
fzf --fish | source
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# --preview-window 60% 表示预览窗口占宽度中的比例
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 'right,60%,border-left'"
set -gx FZF_CTRL_R_OPTS "--preview-window hidden"

# 6. 加载自定义函数文件
if test -f $HOME/.config/fish/tools.fish
    source $HOME/.config/fish/tools.fish
end

if test -f $HOME/.config/fish/abbrs.fish
    source $HOME/.config/fish/abbrs.fish
end

if test -f $HOME/.config/fish/git.fish
    source $HOME/.config/fish/git.fish
end

if test -f $HOME/.config/fish/lastPwd.fish
    source $HOME/.config/fish/lastPwd.fish
end

set -x GEMINI_API_KEY 

# deepseek
set -x DEEPSEEK_API_KEY 

# openrouter
set -x OPENROUTER_API_KEY 
# ollama
set -x OLLAMA_API_BASE 'http://127.0.0.1:11434'

# 7. starship & zoxide
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience
zoxide init fish | source
