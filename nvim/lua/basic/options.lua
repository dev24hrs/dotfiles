--Color
vim.env.TERM = 'xterm-256color'
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Incremental live completion
vim.opt.inccommand = 'nosplit'
vim.opt.ttyfast = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true -- default
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.backspace = 'indent,eol,start' -- default
vim.opt.listchars = 'tab:> ,trail:-,nbsp:+' -- default
vim.opt.list = false
vim.opt.conceallevel = 0

vim.opt.autoread = true -- default
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.completeopt = 'menu,menuone,noselect,noinsert'

-- utf-8
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8' -- default
vim.opt.fileencoding = 'utf-8'

-- Use ripgrep as grep tool
vim.o.grepprg = 'rg --vimgrep --no-heading'
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'

vim.opt.clipboard:append('unnamedplus')
vim.opt.mouse:append('a')
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- On neovim 0.11+, you may use the vim.o.winborder option to set the default border for all floating windows.
vim.opt.winborder = 'single'
-- vim.opt.winborder = 'solid'
