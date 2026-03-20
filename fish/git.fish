# fzf.fish 风格集成脚本 - Git 操作合集
# 包含：Git Status (Files), Git Log (Hashes), Git Branches

# --- 环境检查与预处理 ---

function _fzf_git_check_deps
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
    or return 1
end

# --- 1. Git Status (对应文件选择与操作) ---
function gs
    _fzf_git_check_deps; or return

    # 1. 智能预览逻辑：根据文件状态（已暂存、未暂存、未追踪）显示不同的 Diff
    set -l preview_cmd "
        set -l file (string sub --start 4 {})
        set -l status_code (string sub --length 2 {})

        if test -d \"\$file\"
            ls -F --color=always \"\$file\"
        else if string match -q '??' \"\$status_code\"
            # 未追踪文件：显示文件内容
            bat --color=always --style=numbers \"\$file\" 2>/dev/null; or cat \"\$file\"
        else
            # 已追踪文件：合并显示已暂存(staged)和未暂存(unstaged)的变更
            git diff --color=always HEAD -- \"\$file\"
        end"

    # 2. 调用 FZF
    git -c core.quotePath=false status --short | fzf --ansi \
        --multi \
        --header "Git Status | C-d/u: 翻页 | Enter: 退出" \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview "$preview_cmd" \
        --preview-window "right:60%:wrap" | while read -l line
        # 提取文件名
        set -l file (string sub --start 4 $line)
        # 转义文件名（处理空格）并插入到当前命令行
        commandline -i (string escape $file)" "
    end

    # 刷新命令行界面
    commandline -f repaint
end

# --- 2. Git Log (对应 Commit Hashes 选择) ---

function gl
    _fzf_git_check_deps; or return

    set -l preview_cmd "git show --color=always {1} "

    git log --color=always --format="%C(auto)%h%d %s %C(green)(%cr)" | fzf --ansi \
        --no-sort \
        --header "Git Log | C-d/u: 翻页" \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview "$preview_cmd" | while read -l line
        set -l sha (string split ' ' $line)[1]
        commandline -i $sha" "
    end
    commandline -f repaint
end

# --- 3. Git Branches (选择并切换分支) ---

function gb
    _fzf_git_check_deps; or return

    # 预览分支最近的提交记录
    set -l preview_cmd "git log --oneline --graph --date=short --color=always --pretty='format:%C(auto)%cd %h%d %s' (string replace -r '^\*?\s*' '' {1})"

    # 获取全部分支（含远程），按最后提交时间排序
    git branch --all --color=always --sort=-committerdate | grep -v ' -> ' | fzf --ansi \
        --header "Enter: 切换分支 | C-d/u: 预览翻页" \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview "$preview_cmd" | read -l selected

    if test -n "$selected"
        # 1. 清理字符串：去除星号、空格，以及远程分支的前缀 (remotes/origin/)
        set -l branch (string trim $selected | string replace -r '^\*?\s*' '' | string replace -r '^remotes/[^/]+/' '')

        # 2. 执行切换逻辑
        if git switch $branch 2>/dev/null
            commandline -f repaint
        else
            git checkout $branch
        end
    end

    commandline -f repaint
end
