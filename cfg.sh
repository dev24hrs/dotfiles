#!/bin/bash

# 配置路径（建议使用绝对路径，或者确保执行脚本时路径正确）
SRC_DIR="$HOME/.config"
DEST_DIR="$HOME/Documents/Dotfiles"

# 定义排除规则
# 注意：rsync 的排除路径是相对于根目录的相对路径
PUSH_EXCLUDE=(
  "--exclude=/github-copilot/"
  "--exclude=/jgit/"
  "--exclude=/zsh/"
  "--exclude=/.git"
)

PULL_EXCLUDE=(
  "--exclude=.git"
)

usage() {
  echo "Usage: $0 <command>"
  echo "  push  - 从 .config 同步到 Dotfiles"
  echo "  pull  - 从 Dotfiles 同步到 .config"
  exit 1
}

case "$1" in
push)
  if [ ! -d "$SRC_DIR" ]; then
    echo "Error: $SRC_DIR does not exist."
    exit 1
  fi
  mkdir -p "$DEST_DIR"
  rsync -a --delete --quiet "${PUSH_EXCLUDE[@]}" "$SRC_DIR/" "$DEST_DIR/"
  echo "Push Done: $SRC_DIR/ -> $DEST_DIR/"
  ;;
pull)
  if [ ! -d "$DEST_DIR" ]; then
    echo "Error: $DEST_DIR does not exist."
    exit 1
  fi
  mkdir -p "$SRC_DIR"
  rsync -av --quiet "${PULL_EXCLUDE[@]}" "$DEST_DIR/" "$SRC_DIR/"
  echo "Pull Done: $DEST_DIR/ -> $SRC_DIR/"
  ;;
*)
  usage
  ;;
esac
