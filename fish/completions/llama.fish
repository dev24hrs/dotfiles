# Fish shell completions for llama command

# 清除现有补全
complete -c llama -e

# 禁用文件补全（我们只需要特定的补全）
complete -c llama -f

# 检查是否已经输入了子命令
function __llama_using_subcommand
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        if contains -- $cmd[2] cli server bench
            return 0
        end
    end
    return 1
end

# 获取当前子命令
function __llama_current_subcommand
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        echo $cmd[2]
    end
end

# 检查是否已经指定了模型
function __llama_has_model
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 2
        return 0
    end
    return 1
end

# 获取可用模型列表
function __llama_list_models
    set -l models_dir ~/.llama
    if test -d $models_dir
        for model in $models_dir/*.gguf
            set -l model_name (basename $model .gguf)
            echo $model_name
        end
    end
end

# ============================================================================
# 主命令补全
# ============================================================================

# 当没有子命令时，显示子命令选项
complete -c llama -n "not __llama_using_subcommand" -a cli -d 运行命令行交互模式
complete -c llama -n "not __llama_using_subcommand" -a server -d "启动 API 服务器"
complete -c llama -n "not __llama_using_subcommand" -a bench -d 运行性能基准测试

# ============================================================================
# 模型名称补全
# ============================================================================

# 当已经选择了子命令但还没有指定模型时，显示模型列表
complete -c llama -n "__llama_using_subcommand; and not __llama_has_model" -a "(__llama_list_models)" -d 模型文件

# ============================================================================
# CLI 子命令的参数补全
# ============================================================================

# 通用参数（所有子命令都支持）
complete -c llama -n __llama_has_model -l help -s h -d 显示帮助信息
complete -c llama -n __llama_has_model -s m -l model -d 模型文件路径 -r
complete -c llama -n __llama_has_model -l ngl -d "GPU 层数" -r -f -a "0 10 20 30 40 50 99"
complete -c llama -n __llama_has_model -s c -l ctx-size -d 上下文大小 -r -f -a "512 1024 2048 4096 8192 16384 32768"
complete -c llama -n __llama_has_model -s t -l threads -d 线程数 -r -f -a "4 8 16 32"
complete -c llama -n __llama_has_model -l seed -d 随机种子 -r
complete -c llama -n __llama_has_model -s n -l n-predict -d "生成 token 数量" -r -f -a "128 256 512 1024 2048 -1"

# CLI 专用参数
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -s p -l prompt -d 初始提示词 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -s f -l file -d 从文件读取提示词 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l color -d 启用彩色输出
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -s i -l interactive -d 交互模式
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l interactive-first -d 交互优先模式
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -s ins -l instruct -d 指令模式
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l reverse-prompt -d "反向提示词（停止标记）" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l in-prefix -d 输入前缀 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l in-suffix -d 输入后缀 -r

# 采样参数
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l temp -d 温度参数 -r -f -a "0.1 0.3 0.5 0.7 0.8 0.9 1.0 1.2"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l top-k -d "Top-K 采样" -r -f -a "10 20 40 50 100"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l top-p -d "Top-P 采样" -r -f -a "0.1 0.5 0.9 0.95 0.99 1.0"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l repeat-penalty -d 重复惩罚 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l repeat-last-n -d 重复检查窗口 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l min-p -d 最小概率阈值 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l tfs -d "Tail Free Sampling" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l typical -d "Typical 采样" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l mirostat -d "Mirostat 采样模式" -r -f -a "0 1 2"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l mirostat-lr -d "Mirostat 学习率" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l mirostat-ent -d "Mirostat 目标熵" -r

# 高级参数
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -s b -l batch-size -d 批处理大小 -r -f -a "128 256 512 1024 2048"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l keep -d "保留的上下文 token 数" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l rope-freq-base -d "RoPE 频率基数" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l rope-freq-scale -d "RoPE 频率缩放" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l ignore-eos -d "忽略 EOS token"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = cli" -l no-penalize-nl -d 不惩罚换行符

# ============================================================================
# SERVER 子命令的参数补全
# ============================================================================

complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l host -d 绑定主机地址 -r -f -a "0.0.0.0 127.0.0.1 localhost"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l port -d 绑定端口 -r -f -a "8080 8081 8000 9000 3000"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l path -d 服务路径前缀 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l timeout -d "服务器超时时间（秒）" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l embedding -d 启用嵌入模式
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l api-key -d "API 密钥（认证）" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l api-key-file -d "API 密钥文件路径" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l ssl-key-file -d "SSL 私钥文件" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l ssl-cert-file -d "SSL 证书文件" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l parallel -d 并行处理槽位数 -r -f -a "1 2 4 8 16"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l cont-batching -d 启用连续批处理
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l nobrowser -d 启动时不打开浏览器
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l system-prompt-file -d 系统提示词文件 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l log-format -d 日志格式 -r -f -a "text json"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l metrics -d "启用 Prometheus 指标"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l slot-save-path -d 保存槽位状态的路径 -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = server" -l chat-template -d 聊天模板 -r

# ============================================================================
# BENCH 子命令的参数补全
# ============================================================================

complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -s p -l n-prompt -d "Prompt token 数量" -r -f -a "64 128 256 512 1024"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -s n -l n-gen -d "生成的 token 数量" -r -f -a "64 128 256 512 1024"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l repetitions -d 重复测试次数 -r -f -a "1 3 5 10 20"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l output -d 输出格式 -r -f -a "csv json md sql"
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -s v -l verbose -d 详细输出
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l low-vram -d 低显存模式
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l tensor-split -d "张量分割（多 GPU）" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l main-gpu -d "主 GPU 索引" -r
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l no-mmap -d 不使用内存映射
complete -c llama -n "__llama_has_model; and test (__llama_current_subcommand) = bench" -l numa -d "NUMA 优化"

# ============================================================================
# GPU 和硬件相关参数（所有子命令）
# ============================================================================

complete -c llama -n __llama_has_model -s ngl -l n-gpu-layers -d "卸载到 GPU 的层数" -r -f -a "0 10 20 30 40 50 99"
complete -c llama -n __llama_has_model -l main-gpu -d "主 GPU 索引" -r
complete -c llama -n __llama_has_model -l tensor-split -d "多 GPU 张量分割比例" -r
complete -c llama -n __llama_has_model -l no-mmap -d 禁用内存映射
complete -c llama -n __llama_has_model -l mlock -d 锁定模型到内存
complete -c llama -n __llama_has_model -l numa -d "启用 NUMA 优化"
