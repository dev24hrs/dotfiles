# 禁用默认的文件补全，因为该命令不需要路径参数
complete -c brew-clean-taps -f

# 为命令本身添加描述信息
complete -c brew-clean-taps -d "扫描并清理 Homebrew 中未使用的 Taps"
