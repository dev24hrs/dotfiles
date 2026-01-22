return {
  'j-hui/fidget.nvim',
  event = 'LspAttach', -- LSP 客户端附加时加载
  opts = {
    progress = {
      -- 进度消息的轮询和抑制
      poll_rate = 0, -- 默认值通常是 0，即尽可能快地更新
      suppress_on_insert = true, -- **在插入模式下抑制新消息，避免打字时弹出**
      ignore_done_already = true, -- 忽略已完成的任务
      ignore_empty_message = true, -- 忽略空消息任务
      clear_on_detach = function(client_id)
        local client = vim.lsp.get_client_by_id(client_id)
        return client and client.name or nil
      end,
      notification_group = function(msg)
        return msg.lsp_client.name
      end,
      ignore = {}, -- 要忽略的 LSP 服务器列表
    },
    notification = {
      window = {
        winblend = 0,
        border = 'none',
        avoid = { 'NvimTree' },
      },
    },
  },
}
