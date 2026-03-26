-- 1. 性能与基础设置
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

vim.opt.termguicolors = true
vim.opt.signcolumn = 'number' -- config with vim.diagnostic.config.signs
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.updatetime = 250 -- 稍微缩短，使 LSP 悬浮窗和诊断反应更快
vim.opt.timeoutlen = 300 -- 缩短快捷键等待时间，操作更跟手
vim.o.completeopt = 'menu,menuone,noselect,noinsert'
vim.opt.inccommand = 'nosplit'
vim.opt.ttyfast = true --default

-- 2. UI 渲染与交互
-- vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3 -- 全局状态栏，避免多窗口时状态栏重复
vim.opt.showmode = false -- 既然有状态栏，就没必要在左下角显示 -- INSERT -- 了
vim.opt.conceallevel = 2 -- Markdown 等文件中有更好的预览效果
vim.opt.winborder = 'single' -- On neovim 0.11+, you may use the vim.o.winborder option to set the default border for all floating windows.
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.o.listchars = 'tab:> ,trail:-,nbsp:+' --default

-- 3. 搜索与匹配
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true -- default
vim.opt.incsearch = true -- default
vim.opt.scrolloff = 8 -- 增加到 8，让光标始终离上下边缘有一定距离
vim.opt.sidescrolloff = 5

-- 4. 缩进与排版
-- INFO : tabstop & shiftwidth & expandtab & softtabstop refer to langIndent.lua to different languages settings
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.wrap = true
require('basic.langIndent')

-- 5. 折叠优化
require('basic.folding')

-- 6. 杂项
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.iskeyword:append('-') -- 让 'go-to' 这种词被视为一个整体
vim.opt.jumpoptions = 'stack' -- - helps jumps out of the definition without too many C-o & gd
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 大文件处理逻辑 1.5M
vim.g.markdown_folding = 1 -- markdown 文件默认开启折叠

-- 7. 编码设置
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 8. 搜索增强 (使用 Ripgrep)
vim.o.grepprg = 'rg --vimgrep --no-heading'
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
