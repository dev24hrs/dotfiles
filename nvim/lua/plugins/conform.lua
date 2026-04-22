vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        yaml = { "yamlfmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_format", "ruff" },
        sql = { "sqlfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
        -- rust = { "rustfmt" }, -- comes with Rust installation
        fish = { "fish_indent" }, -- comes with Fish installation
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if vim.api.nvim_buf_get_name(bufnr):match("/node_modules/") then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
})
vim.keymap.set({ "n", "v" }, "<leader>w", function()
    conform.format({
        async = true,
        lsp_format = "fallback",
    }, function(err)
        if err then
            vim.notify("Format error: " .. err, vim.log.levels.ERROR, { title = "Conform" })
            return
        end
        vim.schedule(function()
            if vim.bo.modified then
                vim.cmd("update")
                vim.notify("Formatted & Saved", vim.log.levels.INFO, { title = "Conform" })
            else
                vim.cmd("update")
            end
        end)
    end)
end, { desc = "[Conform]: Format and Saved" })

-- 保存时自动删除行尾空格
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", vim.fn.getpos("."))
    end,
})
