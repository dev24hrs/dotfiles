vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local function fold_virt_text(result, start_text, lnum)
    local text = ""
    local hl
    local line_len = #start_text

    for i = 1, line_len do
        local char = start_text:sub(i, i)
        local new_hl = nil

        local sem_tokens = vim.lsp.semantic_tokens.get_at_pos(0, lnum, i - 1)
        if sem_tokens and #sem_tokens > 0 then
            new_hl = "@lsp." .. sem_tokens[1].type
        else
            local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, lnum, i - 1)
            if ok and captures and #captures > 0 then
                local top = captures[1]
                local top_priority = 0

                if top.metadata and top.metadata.priority then
                    top_priority = tonumber(top.metadata.priority) or 0
                end
                if #captures > 1 then
                    for j = 2, #captures do
                        local cap = captures[j]
                        local prio = 0
                        if cap.metadata and cap.metadata.priority then
                            prio = tonumber(cap.metadata.priority) or 0
                        end
                        if prio > top_priority then
                            top = cap
                            top_priority = prio
                        end
                    end
                end

                new_hl = "@" .. top.capture
            end
        end

        if new_hl and new_hl ~= hl then
            if text ~= "" then
                table.insert(result, { text, hl })
                text = ""
            end
            hl = new_hl
        end

        text = text .. char
    end

    if text ~= "" then
        table.insert(result, { text, hl })
    end
end

function _G.custom_foldtext()
    local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
    local nline = vim.v.foldend - vim.v.foldstart
    local result = {}
    fold_virt_text(result, start_text, vim.v.foldstart - 1)
    table.insert(result, { "  ", nil })

    table.insert(result, { "    ...... 󰁂  " .. nline .. " lines folded", "Character" })
    return result
end

local function remove_fold_background()
    vim.api.nvim_set_hl(0, "folded", { bg = "none", fg = "none", italic = true })
end
vim.api.nvim_create_autocmd("colorscheme", {
    pattern = "*",
    callback = function()
        vim.schedule(remove_fold_background)
    end,
})

vim.keymap.set("n", "zf", "za", { desc = "[Folding]: Toggle code block", noremap = true, silent = true })
vim.keymap.set("n", "zr", "zR", { desc = "[Folding]: Unfold all code blocks", noremap = true, silent = true })
vim.keymap.set("n", "zm", "zM", { desc = "[Folding]: Fold all code blocks", noremap = true, silent = true })

vim.opt.foldtext = "v:lua.custom_foldtext()"
