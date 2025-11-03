vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.signcolumn = 'auto'

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
vim.opt.wrap = true

-- Tabs & Indentation
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 0
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true -- default
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true -- default
vim.opt.incsearch = true -- default
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.backspace = 'indent,eol,start' -- default
vim.opt.listchars = 'tab:> ,trail:-,nbsp:+' -- default
vim.opt.list = true
vim.opt.conceallevel = 0

vim.opt.autoread = true -- default
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

vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

-- On neovim 0.11+, you may use the vim.o.winborder option to set the default border for all floating windows.
vim.opt.winborder = 'single'
-- helps jumps out of the definition without too many C-o & gd
vim.opt.jumpoptions = 'stack'
-- Big file limit
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- folding
require('basic.folding')
