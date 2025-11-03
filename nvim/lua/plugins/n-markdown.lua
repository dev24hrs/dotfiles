return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown' },
      sign = { enabled = false },
      code = {
        border = 'thin',
        left_pad = 1,
        right_pad = 1,
        sign = false,
        style = 'language',
      },
      heading = {
        icons = { ' 󰼏 ', ' 󰎨 ', ' 󰼑 ', ' 󰎲 ', ' 󰼓 ', ' 󰎴 ' },
        border = false,
        render_modes = true, -- keep rendering while inserting
      },
      checkbox = {
        unchecked = { icon = '✘' },
        checked = { icon = '✔' },
        custom = {
          question = { raw = '[?]', rendered = '', highlight = 'RenderMarkdownQuestion' },
          todo = { raw = '[>]', rendered = '󰦖', highlight = 'RenderMarkdownTodo' },
          canceled = { raw = '[-]', rendered = '', scope_highlight = '@text.strike' },
          important = { raw = '[!]', rendered = '', highlight = 'DiagnosticWarn' },
          favorite = { raw = '[~]', rendered = '', highlight = 'RenderMarkdownFavorite' },
        },
      },
      pipe_table = {
        alignment_indicator = '─',
        border = { '╭', '┬', '╮', '├', '┼', '┤', '╰', '┴', '╯', '│', '─' },
      },
      anti_conceal = {
        disabled_modes = { 'n' },
        ignore = {
          bullet = true, -- render bullet in insert mode
          head_border = true,
          head_background = true,
        },
      },
      -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
      win_options = { concealcursor = { rendered = 'nvc' } },
      completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
      },
    },
  },
  {
    '3rd/image.nvim',
    ft = { 'markdown' },
    build = false,
    opts = {
      processor = 'magick_cli',
      window_overlap_clear_enabled = true,
    },
  },
  {
    'HakonHarnes/img-clip.nvim',
    -- require pngpaste on macos
    ft = { 'markdown' },
    event = 'VeryLazy',
    opts = {
      default = {
        -- save images to same directory as current file with .assest suffix
        dir_path = function()
          return string.gsub(vim.fn.expand('%:t'), '%..*', '') .. '.assest'
        end,
        insert_mode_after_paste = false,
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
      },
      filetypes = {
        markdown = {
          template = '![$FILE_NAME_NO_EXT]($FILE_PATH)', ---@type string | fun(context: table): string
        },
      },
    },
    keys = {
      -- suggested keymap
      { '<leader>pp', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
  },
}
