# Fish Shell

## 安装

```bash
brew install fish
```

## fish 作为默认shell

```bash
# Fish 路径写入信任列表
echo $(which fish) | sudo tee -a /etc/shells

# 切换默认 Shell
chsh -s $(which fish)
```

## 设置

add to config.fish & source ~/.config/fish/config.fish

### 基础设置

```bash
set -g fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR nvim

# init homebrew
eval (/opt/homebrew/bin/brew shellenv)

# set XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME "$HOME/.config"
```

### 环境变量

```bash
# 导出开发环境变量 (使用 set -gx)
set -gx GOPATH $HOME/Documents/Tools/GoPath
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
set -gx MAVEN_HOME $HOME/Documents/Tools/maven/maven-3.9.9
set -gx GRADLE_HOME $HOME/Documents/Tools/gradle/gradle-8.12
set -gx GRADLE_USER_HOME $HOME/Documents/Tools/gradle/gradle-repository

#  路径管理
# $GOPATH/bin: go install xxx 的存放路径
# /opt/homebrew/opt/go: 是 Homebrew 指向当前 Go 版本的软链
# 可用于多个 Go 版本时指定某一个版本

fish_add_path $GOPATH/bin
fish_add_path /opt/homebrew/opt/go/bin
fish_add_path $JAVA_HOME/bin
fish_add_path $MAVEN_HOME/bin
fish_add_path $GRADLE_HOME/bin
```

### 别名

```bash
alias lg='lazygit'
alias mu='musicfox'
alias bt='btop'
# lsd
alias ls='lsd'
alias la='lsd -la -A -X'
alias lt='lsd --tree'
```

### 加载自定义函数文件

```bash
if test -f $HOME/.config/fish/tools.fish
    source $HOME/.config/fish/tools.fish
end

if test -f $HOME/.config/fish/abbrs.fish
    source $HOME/.config/fish/abbrs.fish
end
```

### 配置fzf

```bash
fzf --fish | source
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# --preview-window 60% 表示预览窗口占宽度中的比例
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window 'right,60%,border-left'"
set -gx FZF_CTRL_R_OPTS "--preview-window hidden"
```

### 配置starship

```bash
# 自定义 starship 配置文件的路径
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# 文件末尾
starship init fish | source
```

### 配置zoxide

```bash
# 文件末尾
zoxide init fish | source
```

## 自定义function

`fish/functions` 目录下可以存放自定义的一些功能, fish 会自动懒加载相关function,如 `brew-clean-taps.fish` -> `function brew-clean-taps -d "清理未使用的 Homebrew Taps" `

与上面的`source $HOME/.config/fish/abbrs.fish`相比:

- `functions` 目录下的会懒加载
- `source` 方式加载的函数会被fish 初始化, 当过多时会影响启动效率
