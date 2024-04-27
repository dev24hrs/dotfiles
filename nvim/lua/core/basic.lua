--Color
vim.env.TERM = 'xterm-256color'
vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'

-- Incremental live completion
vim.opt.inccommand = 'nosplit'
vim.opt.ttyfast = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.cmdheight = 1
vim.opt.laststatus = 3

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
-- vim.opt.smarttab = true

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.backspace = 'indent,eol,start'
vim.opt.list = false
vim.opt.listchars = 'tab:»·,nbsp:+,extends:→,precedes:←'
vim.opt.conceallevel = 0

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.completeopt = 'menu,menuone,noselect,noinsert'

-- utf-8
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Use ripgrep as grep tool
vim.o.grepprg = 'rg --vimgrep --no-heading'
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'

vim.opt.clipboard:append('unnamedplus')
vim.opt.mouse:append('a')
vim.opt.iskeyword:append('-')
vim.opt.splitright = true
vim.opt.splitbelow = true

-- folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 20

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- 关闭新行注释
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- 光标回到上次位置
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
      vim.fn.setpos('.', vim.fn.getpos('\'"'))
      vim.cmd('silent! foldopen')
    end
  end,
})
