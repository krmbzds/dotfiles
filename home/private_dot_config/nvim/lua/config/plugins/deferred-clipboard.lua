local M = {
  "EtiamNullam/deferred-clipboard.nvim",
}

function M.config()
  local status_ok, deferred_clipboard = pcall(require, "deferred-clipboard")
  if not status_ok then
    return
  end

  deferred_clipboard.setup({ fallback = "unnamedplus", lazy = true })
end

return M
