#!/bin/bash

# --- 配置区 ---
DOT_REPO="$HOME/Documents/dotfiles"
CONFIG_DIR="$HOME/.config"

# 定义恢复清单 (目标路径 | 源备份子目录 | 描述)
LIST=(
  "$CONFIG_DIR/nvim             | nvim            | Neovim"
  "$CONFIG_DIR/fish             | fish            | Fish"
  "$CONFIG_DIR/tmux             | tmux            | Tmux"
  "$CONFIG_DIR/wezterm          | wezterm         | Wezterm"
  "$CONFIG_DIR/ghostty          | ghostty         | Ghostty"
  "$CONFIG_DIR/aerospace        | aerospace       | Aerospace"
  "$CONFIG_DIR/bat              | bat             | Bat"
  "$CONFIG_DIR/starship.toml    | starship.toml   | Starship"
  "$CONFIG_DIR/dots_backup.sh   | dots_backup.sh  | Backup Script"
  "$CONFIG_DIR/dots_restore.sh  | dots_restore.sh | Restore Script"
  "$CONFIG_DIR/README.md        | README.md       | Readme"
)
echo "📥 开始从备份恢复配置 (全量模式)..."

# 确保目标配置根目录存在
mkdir -p "$CONFIG_DIR"

# 设置 IFS 防止路径空格问题
IFS=$'\n'

for line in "${LIST[@]}"; do
  TARGET=$(echo "$line" | cut -d'|' -f1 | xargs)
  SRC_NAME=$(echo "$line" | cut -d'|' -f2 | xargs)
  DESC=$(echo "$line" | cut -d'|' -f3 | xargs)

  SOURCE="$DOT_REPO/$SRC_NAME"

  if [ -e "$SOURCE" ]; then
    # 如果是文件恢复 (如 .tmux.conf)
    if [ -f "$SOURCE" ]; then
      cp "$SOURCE" "$TARGET"
      echo "✅ 已恢复文件: $DESC"
    else
      # 如果是目录恢复 (如 nvim)
      # 确保本地目标目录存在
      mkdir -p "$TARGET"
      # 使用 rsync 进行合并：
      # -a: 归档模式
      # -v: 显示过程
      # 不带 --delete: 确保本地 TARGET 中已有的文件（如本地 README）不会被删
      rsync -a --delete --info=NAME1 "$SOURCE/" "$TARGET/"
      echo "✅ 已完成目录全量合并: $DESC "
    fi
  else
    echo "❌ 错误: 备份源不存在 ($SOURCE)"
  fi
done

echo "🎉 全量恢复完成！环境已与仓库同步。"
