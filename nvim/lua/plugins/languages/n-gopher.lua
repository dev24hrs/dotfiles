---@diagnostic disable: missing-fields
-- this plugin is already lazy-loaded, it adds only about 1ms of load
return {
    'olexsmir/gopher.nvim',
    ft = 'go',

    -- build = function()
    --   vim.cmd.GoInstallDeps()
    -- end,
    config = function()
        require('gopher').setup({
            log_level = vim.log.levels.INFO,
            timeout = 2000,
            installer_timeout = 999999,
            commands = {
                go = 'go',
                gomodifytags = 'gomodifytags',
                gotests = 'gotests',
                impl = 'impl',
                iferr = 'iferr',
            },
            gotests = {
                template = 'default',
                template_dir = nil,
                named = false,
            },
            gotag = {
                transform = 'snakecase',
                default_tag = 'json',
                option = nil,
            },
            iferr = {
                message = nil,
            },
            json2go = {
                interactive_cmd = 'vsplit',
                type_name = nil,
            },
        })
    end,
    keys = {
        { '<leader>gj', '<cmd>GoTagAdd json<cr>', desc = '[Gopher]: Add JSON tags' },
        { '<leader>gy', '<cmd>GoTagAdd yaml<cr>', desc = '[Gopher]: Add YAML tags' },
        { '<leader>gr', '<cmd>GoTagRm json<cr>', desc = '[Gopher]: Remove JSON tags' },
    },
}
