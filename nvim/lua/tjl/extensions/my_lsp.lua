local M = {}

M.buf_get_active_clients_statusline = function()
  local statusline = ''

  local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
  for _, v in pairs(clients) do
    statusline = statusline .. v.name .. ' | '
  end

  if statusline ~= '' then
    statusline = statusline:sub(1, -4)
    statusline = 'lsp clients: ' .. statusline
  end

  return statusline
end

return M
