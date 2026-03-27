function brew-clean --description "Homebrew 综合清理工具"
    # 获取子命令
    set -l subcommand $argv[1]
    set -e argv[1]

    switch "$subcommand"
        case deps
            _tool_brew_clean_deps $argv
        case taps
            _tool_brew_clean_taps $argv
        case -h --help ""
            echo "用法: brew-clean [子命令]"
            echo
            echo "可用子命令:"
            echo "  deps 清理无用的孤儿依赖包"
            echo "  taps 清理没有任何已安装软件的 Tap 仓库"
            echo "  -h, --help  显示此帮助信息"
        case "*"
            echo (set_color red)"未知子命令: $subcommand"(set_color normal)
            brew-clean --help
            return 1
    end

end

# --- 内部私有函数：清理依赖 ---
function _tool_brew_clean_deps

    # set -l orphans (brew leaves)
    set -l orphans (brew leaves --installed-as-dependency)

    echo
    echo (set_color --bold cyan)"==========================================="
    echo "   Homebrew Deps 清理"
    echo "==========================================="$(set_color normal)

    if test -z "$orphans"
        echo (set_color green)"󰄬  系统非常干净，没有发现冗余依赖。"(set_color normal)
        # 顺便建议清理缓存
        read -l -P "󰃥  是否顺便清理旧版本缓存 (brew cleanup)? [y/N] " clean_cache
        if contains (string lower $clean_cache) y yes
            brew cleanup --prune=all
        end
        return
    end

    # 2. 展示这些包及其用途
    echo (set_color yellow)"󱇝  发现以下 $(count $orphans) 个独立依赖（没有其它包依赖它们）："(set_color normal)
    echo -------------------------------------------
    for pkg in $orphans
        set -l info_json (brew info --json=v1 $pkg)
        set -l desc (echo $info_json | jq -r '.[0].desc' 2>/dev/null)
        # 获取安装原因 (on request 还是 dependency)
        set -l reason (brew info --json=v1 $pkg | jq -r '.[0].installed[0].installed_on_request' 2>/dev/null)

        if test "$reason" = true
            set reason_str (set_color blue)"[手动安装]"(set_color normal)
        else
            set reason_str (set_color magenta)"[自动随依赖安装]"(set_color normal)
        end

        echo " • "(set_color --bold)$pkg(set_color normal) " $reason_str"
        echo "   └─ $desc"
    end
    echo -------------------------------------------

    # 3. 交互式操作
    echo (set_color --bold cyan)"󰃥 请选择操作："(set_color normal)
    echo " [y] 批量卸载以上所有包"
    echo " [s] 逐个选择要卸载的包 (Selectively)"
    echo " [q] 退出"

    read -l -P "请输入指令: " action

    switch (string lower $action)
        case y yes
            echo (set_color red)"正在批量卸载..."(set_color normal)
            brew uninstall $orphans
            echo (set_color green)"  批量卸载完成！"(set_color normal)

        case s select
            for pkg in $orphans
                read -l -P "是否卸载 $pkg ? [y/N] " confirm
                if contains (string lower $confirm) y yes
                    brew uninstall $pkg
                end
            end
            echo (set_color green)"  选择性清理完成！"(set_color normal)

        case '*'
            echo (set_color white)"󰜺  操作已取消。"(set_color normal)
    end

    echo (set_color --bold cyan)"==========================================="$(set_color normal)
end

# --- 内部私有函数：清理 Taps ---
function _tool_brew_clean_taps
    echo
    echo (set_color --bold cyan)"==========================================="
    echo "   Homebrew Taps 清理"
    echo "==========================================="$(set_color normal)

    echo (set_color --bold yellow)"󰍉 正在扫描冗余的 Taps..."(set_color normal)
    set -l unused_taps

    # 获取所有已添加的 tap
    for tap in (brew tap)
        # 使用 Fish 原生的 string match 替代 grep，效率更高
        set -l pkgs (brew list --full-name | string match -r "^$tap/")
        set -l pkg_count (count $pkgs)

        if test $pkg_count -eq 0
            echo (set_color yellow)"󱇝 发现无用 Tap: 󰊤 $tap"(set_color normal)
            set -a unused_taps $tap
        end
    end

    # 检查收集到的无用 tap 数量
    set -l unused_count (count $unused_taps)

    if test $unused_count -eq 0
        echo (set_color green)"󰄬 恭喜！没有发现冗余 Tap. 无需清理"(set_color normal)
        echo
        echo (set_color --bold cyan)"==========================================="$(set_color normal)
        return 0
    end

    echo -----------------------------------
    read -l -P "󰃥 是否现在移除这 $unused_count 个无用 Tap? [y/N] " confirm
    # 匹配多种确认输入格式 (y, Y, yes 等)
    if contains -- $confirm y Y yes YES
        for t in $unused_taps
            echo (set_color red)" 正在移除 $t..."(set_color normal)
            brew untap $t
        end
        echo (set_color green)" 清理完成！建议执行 `brew cleanup --prune=all` 释放磁盘空间"(set_color normal)
    else
        echo (set_color white)"󰜺 已取消操作"(set_color normal)
    end
    echo (set_color --bold cyan)"==========================================="$(set_color normal)
end
