#!/bin/bash

# --- 配置区 ---
DOT_REPO="$HOME/Documents/dotfiles"
CONFIG_DIR="$HOME/.config"

# 定义同步清单
# 格式: "源路径 | 目标子目录 | 描述"
LIST=(
	"$CONFIG_DIR/nvim          | nvim          | Neovim"
	"$CONFIG_DIR/fish          | fish          | Fish"
	"$CONFIG_DIR/tmux          | tmux          | Tmux"
	"$CONFIG_DIR/wezterm       | wezterm       | Wezterm"
	"$CONFIG_DIR/ghostty       | ghostty       | Ghostty"
	"$CONFIG_DIR/aerospace     | aerospace     | Aerospace"
	"$CONFIG_DIR/bat           | bat           | Bat"
	"$CONFIG_DIR/starship.toml | starship.toml | Starship"
	"$CONFIG_DIR/dots_backup.sh  | dots_backup.sh  | Backup Script"
	"$CONFIG_DIR/dots_restore.sh | dots_restore.sh | Restore Script"
)

echo "🚀 开始同步备份 (增量合并模式)..."

# 设置 IFS 防止路径空格问题
IFS=$'\n'

for line in "${LIST[@]}"; do
	SRC=$(echo "$line" | cut -d'|' -f1 | xargs)
	DST_NAME=$(echo "$line" | cut -d'|' -f2 | xargs)
	DESC=$(echo "$line" | cut -d'|' -f3 | xargs)

	TARGET="$DOT_REPO/$DST_NAME"

	if [ -e "$SRC" ]; then
		# 如果目标是文件（如 .tmux.conf）
		if [ -f "$SRC" ]; then
			cp "$SRC" "$TARGET"
			echo "✅ 已同步文件: $DESC"
		else
			# 如果目标是目录（如 nvim）
			mkdir -p "$TARGET"
			# rsync 参数说明:
			# -a: 归档模式
			# -v: 显示详情
			# (去掉了 --delete): 如果 TARGET 有而 SRC 没有的文件，会被保留
			rsync -a --info=NAME1 "$SRC/" "$TARGET/"
			echo "✅ 已完成目录增量合并: $DESC "
		fi
	else
		echo "⚠️ 跳过: $SRC (路径不存在)"
	fi
done

echo "🎉 增量同步完成！现在你可以手动进入 $DOT_REPO 进行 Git 操作了。"
