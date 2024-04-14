---@diagnostic disable: missing-fields
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    priority = 1000,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'go',
          'gomod',
          'lua',
          'json',
          'markdown',
          'markdown_inline',
          'sql',
          'yaml',
          'regex',
          'rust',
          'toml',
          'dockerfile',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- disable standard vim highlighting
        },
        indent = { enable = true },
        incremental_selection = { enable = true },
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
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    cmd = 'TSContextToggle',
    ft = { 'lua', 'go' },
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
}
