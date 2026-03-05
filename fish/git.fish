function gs
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Error: Not a git repository."
        return
    end

    git status -s | fzf --ansi --no-multi --reverse \
        --header "Git Status | C-d/u: 翻页 | Enter: 退出" \
        --preview-window 'right:65%:border-left' \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview '
            set -l line {}
            set -l file (string sub --start 4 "$line" | string trim)

            # 定义分割线颜色
            set -l cyan (set_color cyan)
            set -l normal (set_color normal)

            if string match -q "??*" "$line"
                echo "$cyan--- [ UNTRACKED NEW FILE ] ---$normal"
                echo ""
                # 使用 bat 预览并显示文件名
                bat --color=always --style=header,numbers "$file" 2>/dev/null; or cat "$file"
            else
                # 处理已追踪文件
                set -l diff_unstaged (git diff --color=always -- "$file")
                set -l diff_staged (git diff --cached --color=always -- "$file")

                if test -n "$diff_unstaged"
                    echo "$cyan--- [ WORKING TREE CHANGES ] ---$normal"
                    # 过滤掉冗余的 diff 头部信息，直接显示改动
                    git diff --color=always -- "$file" | sed "1,4d"
                end

                if test -n "$diff_staged"
                    if test -n "$diff_unstaged"; echo ""; end
                    echo "$cyan--- [ STAGED CHANGES ] ---$normal"
                    git diff --cached --color=always -- "$file" | sed "1,4d"
                end
            end'
end

function gb
    git branch --color=always | fzf --ansi --reverse \
        --header "切换分支 | C-d/u: 翻页" \
        --preview-window 'right:60%:wrap' \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview 'git log --oneline --graph --color=always -n 10 (string trim {})' | string trim | read -l target
    if test -n "$target"
        git checkout $target
    end
end

function gl
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" | fzf --ansi --no-sort --reverse \
        --header "提交详情 | C-d/u: 翻页" \
        --preview-window 'right:60%:wrap' \
        --bind "ctrl-d:preview-page-down,ctrl-u:preview-page-up" \
        --preview 'git show --color=always (string split " " {})[2]'
end
