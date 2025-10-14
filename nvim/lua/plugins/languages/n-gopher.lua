---@diagnostic disable: undefined-doc-name
-- NOTE: this plugin is already lazy-loaded, it adds only about 1ms of load
return {
  'olexsmir/gopher.nvim',
  ft = 'go',
  -- branch = "develop"
  -- (optional) will update plugin's deps on every update

  -- build = function()
  --   vim.cmd.GoInstallDeps()
  -- end,
  ---@module "gopher"
  ---@type gopher.Config
  opts = {},
}
