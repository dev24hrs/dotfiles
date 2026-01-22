return {
  'mason-org/mason.nvim',
  -- lazy = true, -- Load immediately to ensure PATH is set
  event = { 'BufReadPost', 'BufNewFile', 'VimEnter' },
  -- event = 'VeryLazy',
  cmd = 'Mason',
  build = ':MasonUpdate',
  opts = {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
    ensure_installed = {
      -- LSP servers (matching your vim.lsp.enable() config)
      'lua-language-server', -- Lua LSP lua_ls
      'gopls', -- Go LSP
      'rust-analyzer', -- Rust LSP
      'yaml-language-server', -- YAML LSP yamlls
      'json-lsp', -- JSON LSP  jsonls
      'bash-language-server', -- Bash LSP bashls
      'sqlls', -- SQL LSP
      'marksman', -- Markdown LSP
      'pyright', -- Python LSP

      -- Formatters (for conform.nvim and general use)
      'stylua', -- Lua
      'goimports', --Golang
      'gofumpt', --Golang
      'prettier',
      'prettierd',
      'sqlfmt', -- 'Sql formatter',
      'black', -- Python
      'isort', -- Python
      'shfmt', -- Shell formatter
      'markdown-toc', -- Markdown
      'yamlfmt', -- YAML
      'taplo', -- TOML

      -- Linters
      'golangci-lint', -- Go linting
      'luacheck', -- Lua linting
      'shellcheck', -- Shell linter
      'yamllint', -- YAML linting
      'jsonlint', -- JSON linting
      'sqlfluff', -- SQL linting
      -- 'markdownlint-cli2', -- Markdown linting

      -- Debuggers--
      'delve', -- Go debugger
    },
  },
  config = function(_, opts)
    require('mason').setup(opts)

    -- Auto-install ensure_installed tools with better error handling
    local registry = require('mason-registry')
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        if registry.has_package(tool) then
          local p = registry.get_package(tool)
          if not p:is_installed() then
            vim.notify('Mason: Installing ' .. tool .. '...', vim.log.levels.INFO)
            p:install():once('closed', function()
              if p:is_installed() then
                vim.notify('Mason: Successfully installed ' .. tool, vim.log.levels.INFO)
              else
                vim.notify('Mason: Failed to install ' .. tool, vim.log.levels.ERROR)
              end
            end)
          end
        else
          vim.notify("Mason: Package '" .. tool .. "' not found", vim.log.levels.WARN)
        end
      end
    end

    if registry.refresh then
      registry.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
