---@diagnostic disable: missing-fields
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    priority = 1000,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'lua',
        'vim',
        'vimdoc',
        'json',
        'markdown',
        'markdown-inline',
        'sql',
        'yaml',
        'regex',
        'rust',
        'toml',
        'html',
        'dockerfile',
      },
    },
    config = function(_, opts)
      local nvim_treesitter = require('nvim-treesitter')
      nvim_treesitter.setup({
        -- ensure_installed = opts.ensure_installed,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- disable standard vim highlighting
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>', -- Enter to start selecting
            node_incremental = '<CR>',
            node_decremental = '<BS>', -- Backspace to shrink
          },
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
        sync_install = true,
        auto_install = true,
        autotag = {
          enable = true,
        },
      })
      local pattern = {}
      for _, parser in ipairs(opts.ensure_installed) do
        local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)
        if not has_parser then
          -- Needs restart to take effect
          nvim_treesitter.install(parser)
        else
          vim.list_extend(pattern, vim.treesitter.language.get_filetypes(parser))
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = pattern,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    ft = { 'lua', 'go', 'rust', 'toml', 'yaml', 'json', 'markdown', 'markdown.mdx' },
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 0,
        line_numbers = true,
        trim_scope = 'outer',
        min_window_height = 0,
        mode = 'cursor',
        separator = nil,
        zindex = 20,
        patterns = {
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
          },
          tex = { 'chapter', 'section', 'subsection', 'subsubsection' },
          rust = { 'impl_item' },
          markdown = { 'section' },
          elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
          },
          json = { 'pair' },
          yaml = { 'block_mapping_pair' },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
    config = function() end,
  },
}
