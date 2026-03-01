return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Initialize DAP UI
      dapui.setup()
      require('dap-go').setup()

      -- Automatically open/close UI when debugging starts/ends
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Keybindings
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end)
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end)
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end)
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end)
      vim.keymap.set('n', '<leader>b', function()
        dap.toggle_breakpoint()
      end)

      -- dap colors
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#fb4934' }) -- Gruvbox Red
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#83a598' }) -- Gruvbox Blue
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#fabd2f' }) -- Gruvbox Yellow
    end,
  },
}
