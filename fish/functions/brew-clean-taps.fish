function brew-clean-taps -d "清理未使用的 Homebrew Taps"
    echo "󰍉 正在扫描无用的 Homebrew Taps..."
    set -l unused_taps

    # 获取所有已添加的 tap
    for tap in (brew tap)
        # 使用 Fish 原生的 string match 替代 grep，效率更高
        set -l pkgs (brew list --full-name | string match -r "^$tap/")
        set -l pkg_count (count $pkgs)

        if test $pkg_count -eq 0
            echo "󱇝 发现无用 Tap: 󰊤 $tap"
            set -a unused_taps $tap
        end
    end

    # 检查收集到的无用 tap 数量
    set -l unused_count (count $unused_taps)

    if test $unused_count -eq 0
        echo "󰄬 恭喜！所有 Tap 都有对应的已安装软件，无需清理。"
        return 0
    end

    echo -----------------------------------
    read -l -P "󰃥 是否现在移除这 $unused_count 个无用 Tap? [y/N] " confirm
    # 匹配多种确认输入格式 (y, Y, yes 等)
    if contains -- $confirm y Y yes YES
        for t in $unused_taps
            echo " 正在移除 $t..."
            brew untap $t
        end
        echo " 清理完成！建议执行 `brew cleanup --prune=all` 释放磁盘空间。"
    else
        echo "󰜺 已取消操作。"
    end
end
