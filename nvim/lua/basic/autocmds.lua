-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- go to last position when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, { pattern = '*', command = 'set nocursorline', group = cursorGrp })

-- Enable spell checking for certain file types
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufReadPost', 'BufNewFile' }, {
--   pattern = { '*.md', 'markdown' },
--   callback = function()
--     vim.wo.linebreak = true
--     -- vim.wo.breakindent = true
--     vim.wo.colorcolumn = '150'
--     -- vim.opt.spell = true
--     -- vim.opt.spelllang = 'en_us'
--   end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
