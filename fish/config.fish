set -g fish_greeting ""

# 1. 初始化外部工具
/opt/homebrew/bin/brew shellenv | source

# 2. 导出开发环境变量 (使用 set -gx)
set -gx GOPATH $HOME/Documents/Tools/GoPath
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
set -gx MAVEN_HOME $HOME/Documents/Tools/maven/maven-3.9.9
set -gx GRADLE_HOME $HOME/Documents/Tools/gradle/gradle-8.12
set -gx GRADLE_USER_HOME $HOME/Documents/Tools/gradle/gradle-repository

# 3. 路径管理
fish_add_path $GOPATH/bin
fish_add_path $JAVA_HOME/bin
fish_add_path $MAVEN_HOME/bin
fish_add_path $GRADLE_HOME/bin

# 4. 别名 (Alias)
alias cat='bat'
alias lg='lazygit'
alias mu='musicfox'
# lsd
alias ls='lsd'
alias la='lsd -la'
alias lt='lsd --tree'
# tmux
alias ts='tmux source-file ~/.config/tmux/tmux.conf'
alias tl='tmux ls'
alias ta='tmux attach'
alias tn='tmux new -s'
alias tk='tmux kill-session -t'

# 5. FZF 默认选项
set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --info=inline"

# 6. 加载自定义函数文件
if test -f $HOME/.config/fish/tools.fish
    source $HOME/.config/fish/tools.fish
end

if test -f $HOME/.config/fish/abbrs.fish
    source $HOME/.config/fish/abbrs.fish
end

if test -f $HOME/.config/fish/lastPwd.fish
    source $HOME/.config/fish/lastPwd.fish
end

# 7. starship & zoxide
function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience
zoxide init fish | source
